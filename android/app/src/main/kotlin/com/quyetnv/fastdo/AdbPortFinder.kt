package com.quyetnv.fastdo

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.net.wifi.WifiManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import java.net.InetSocketAddress
import java.net.Socket
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger

object AdbPortFinder {
    @Volatile
    private var lastDiscoveredPort: String? = null
    private val currentSessionId = AtomicInteger(0)

    private var isDiscovering = false
    private var multicastLock: WifiManager.MulticastLock? = null
    private var discoveryListener: NsdManager.DiscoveryListener? = null

    private val bgExecutor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private val discoveryInProgress = AtomicBoolean(false)

    fun getCachedPort(): String? = lastDiscoveredPort

    fun clearCachedPort() {
        currentSessionId.incrementAndGet()
        lastDiscoveredPort = null
        discoveryInProgress.set(false)
    }

    fun reset(context: Context? = null) {
        currentSessionId.incrementAndGet()
        lastDiscoveredPort = null
        discoveryInProgress.set(false)
        if (context != null) {
            stopNsdDiscovery(context)
        }
    }

    fun findPort(context: Context, onPortFound: ((String) -> Unit)? = null) {
        if (lastDiscoveredPort != null) return
        if (!discoveryInProgress.compareAndSet(false, true)) return

        val sessionId = currentSessionId.incrementAndGet()

        executeDiscovery(context, sessionId, onPortFound)

        // Retry after 1.2s and 2.5s (adbd takes ~1-2s to start and bind listening port on Android)
        mainHandler.postDelayed({
            if (sessionId == currentSessionId.get() && lastDiscoveredPort == null) {
                executeDiscovery(context, sessionId, onPortFound)
            }
        }, 1200)

        mainHandler.postDelayed({
            if (sessionId == currentSessionId.get() && lastDiscoveredPort == null) {
                executeDiscovery(context, sessionId, onPortFound)
            }
        }, 2600)
    }

    private fun executeDiscovery(context: Context, sessionId: Int, onPortFound: ((String) -> Unit)?) {
        bgExecutor.execute {
            if (sessionId != currentSessionId.get()) return@execute

            // 1. Root / getprop check off the main thread with strict process timeout
            val rootPort = getPortViaRoot()
            if (rootPort != null && sessionId == currentSessionId.get()) {
                lastDiscoveredPort = rootPort
                discoveryInProgress.set(false)
                mainHandler.post { onPortFound?.invoke(rootPort) }
                return@execute
            }

            // 2. SystemProperties reflection off the main thread
            val sysPropPort = getPortViaSystemProperties()
            if (sysPropPort != null && sessionId == currentSessionId.get()) {
                lastDiscoveredPort = sysPropPort
                discoveryInProgress.set(false)
                mainHandler.post { onPortFound?.invoke(sysPropPort) }
                return@execute
            }

            // 3. Check specifically if classic ADB port 5555 is active
            if (isPortOpen("127.0.0.1", 5555, 80) && sessionId == currentSessionId.get()) {
                lastDiscoveredPort = "5555"
                discoveryInProgress.set(false)
                mainHandler.post { onPortFound?.invoke("5555") }
                return@execute
            }

            // 4. mDNS / NsdManager Discovery for official Android Wireless Debugging (_adb-tls-connect._tcp)
            val localIp = DevSettingsHelper.getWifiIpAddress(context)
            mainHandler.post {
                if (sessionId == currentSessionId.get()) {
                    startNsdDiscovery(context, localIp, sessionId, onPortFound)
                }
            }
        }
    }

    private fun startNsdDiscovery(
        context: Context,
        localIp: String?,
        sessionId: Int,
        onPortFound: ((String) -> Unit)?
    ) {
        try {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (multicastLock == null && wifiManager != null) {
                multicastLock = wifiManager.createMulticastLock("FastDOMulticastLock").apply {
                    setReferenceCounted(false)
                    acquire()
                }
            }

            val nsdManager = context.getSystemService(Context.NSD_SERVICE) as? NsdManager ?: return

            if (isDiscovering) return

            discoveryListener = object : NsdManager.DiscoveryListener {
                override fun onDiscoveryStarted(serviceType: String) {
                    isDiscovering = true
                }

                override fun onServiceFound(serviceInfo: NsdServiceInfo) {
                    if (sessionId != currentSessionId.get()) return

                    val type = serviceInfo.serviceType
                    if (type.contains("_adb-tls-connect") || type.contains("_adb")) {
                        try {
                            nsdManager.resolveService(serviceInfo, object : NsdManager.ResolveListener {
                                override fun onResolveFailed(info: NsdServiceInfo, errorCode: Int) {}

                                override fun onServiceResolved(resolvedInfo: NsdServiceInfo) {
                                    if (sessionId != currentSessionId.get()) return

                                    val resolvedHost = resolvedInfo.host?.hostAddress
                                    val port = resolvedInfo.port.toString()

                                    val isMatch = localIp == null || resolvedHost == null ||
                                            resolvedHost == localIp || resolvedHost == "127.0.0.1" ||
                                            resolvedHost.startsWith("127.")

                                    if (isMatch && port != "0" && port != "-1") {
                                        lastDiscoveredPort = port
                                        discoveryInProgress.set(false)
                                        mainHandler.post {
                                            if (sessionId == currentSessionId.get()) {
                                                onPortFound?.invoke(port)
                                            }
                                        }
                                        // Stop discovery once resolved to conserve battery and CPU
                                        stopNsdDiscovery(context)
                                    }
                                }
                            })
                        } catch (_: Exception) {}
                    }
                }

                override fun onServiceLost(serviceInfo: NsdServiceInfo) {}
                override fun onDiscoveryStopped(serviceType: String) {
                    isDiscovering = false
                }
                override fun onStartDiscoveryFailed(serviceType: String, errorCode: Int) {
                    isDiscovering = false
                }
                override fun onStopDiscoveryFailed(serviceType: String, errorCode: Int) {
                    isDiscovering = false
                }
            }

            nsdManager.discoverServices("_adb-tls-connect._tcp", NsdManager.PROTOCOL_DNS_SD, discoveryListener)

            mainHandler.postDelayed({
                if (sessionId == currentSessionId.get()) {
                    stopNsdDiscovery(context)
                    discoveryInProgress.set(false)
                }
            }, 8000)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopNsdDiscovery(context: Context) {
        try {
            val nsdManager = context.getSystemService(Context.NSD_SERVICE) as? NsdManager
            if (isDiscovering && discoveryListener != null && nsdManager != null) {
                nsdManager.stopServiceDiscovery(discoveryListener)
                isDiscovering = false
                discoveryListener = null
            }
            if (multicastLock?.isHeld == true) {
                multicastLock?.release()
                multicastLock = null
            }
        } catch (_: Exception) {
            isDiscovering = false
            discoveryListener = null
        }
    }

    private fun isPortOpen(host: String, port: Int, timeoutMs: Int): Boolean {
        return try {
            val socket = Socket()
            socket.connect(InetSocketAddress(host, port), timeoutMs)
            socket.close()
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun getPortViaRoot(): String? {
        var process: Process? = null
        try {
            process = Runtime.getRuntime().exec(arrayOf("su", "-c", "getprop service.adb.tls.port"))
            val finished = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                process.waitFor(1200, TimeUnit.MILLISECONDS)
            } else {
                true
            }
            if (finished && process.exitValue() == 0) {
                val port = process.inputStream.bufferedReader().readLine()?.trim()
                if (!port.isNullOrEmpty() && port != "0" && port != "-1") {
                    return port
                }
            } else {
                process.destroy()
            }
        } catch (_: Exception) {
            process?.destroy()
        }

        var tcpProcess: Process? = null
        try {
            tcpProcess = Runtime.getRuntime().exec(arrayOf("su", "-c", "getprop service.adb.tcp.port"))
            val finished = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                tcpProcess.waitFor(1200, TimeUnit.MILLISECONDS)
            } else {
                true
            }
            if (finished && tcpProcess.exitValue() == 0) {
                val port = tcpProcess.inputStream.bufferedReader().readLine()?.trim()
                if (!port.isNullOrEmpty() && port != "0" && port != "-1") {
                    return port
                }
            } else {
                tcpProcess.destroy()
            }
        } catch (_: Exception) {
            tcpProcess?.destroy()
        }

        return null
    }

    private fun getPortViaSystemProperties(): String? {
        try {
            val systemProperties = Class.forName("android.os.SystemProperties")
            val getMethod = systemProperties.getMethod("get", String::class.java, String::class.java)

            val tlsPort = getMethod.invoke(null, "service.adb.tls.port", "") as? String
            if (!tlsPort.isNullOrEmpty() && tlsPort != "0" && tlsPort != "-1") {
                return tlsPort
            }

            val tcpPort = getMethod.invoke(null, "service.adb.tcp.port", "") as? String
            if (!tcpPort.isNullOrEmpty() && tcpPort != "0" && tcpPort != "-1") {
                return tcpPort
            }
        } catch (_: Exception) {}
        return null
    }
}
