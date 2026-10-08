---
name: sub-agent-orchestration
description: Plans, delegates, and integrates parallel repository work in Google Antigravity, Claude Code, or Codex when the user explicitly asks for multiple agents, delegation, teamwork, or sub-agent orchestration. Uses high-reasoning orchestrators and lower-cost execution workers without delegating architecture. Does not apply to ordinary single-agent tasks.
---

# Sub-Agent Orchestration

Act as the architect, planner, orchestrator, and final reviewer. Use sub-agents to parallelize genuinely independent work, isolate bounded investigations, or execute a clear specification. The primary agent remains responsible for architecture, integration, verification, and the final result.

This is a portable Agent Skill. Detect the current host from its available tools instead of assuming one product's tool names:

- In Google Antigravity, use `define_subagent` and `invoke_subagent` when available.
- In Claude Code, use the Agent/sub-agent capability and versionless model-family aliases.
- In Codex, use the available collaboration/spawn-agent tools.
- If the host cannot select a requested model, do not pretend that it did. Use the closest available role-equivalent model and report the substitution.

## Authorization boundary

Spawn sub-agents only when the user or an applicable project instruction explicitly requests delegation, multiple agents, parallel work, or sub-agent orchestration. This skill does not itself broaden permissions for external writes, deployments, destructive actions, or production changes.

Do not spawn an agent merely because a slot is available. If the task can be completed cleanly in a few focused steps, do it in the primary agent.

## Orchestration workflow

Before delegating:

1. Understand the user's outcome and acceptance criteria.
2. Inspect enough of the repository to identify its architecture and current state.
3. Split the goal into coherent work items and record their dependencies.
4. Freeze any shared contract before parallel streams begin.
5. Check that agents will not edit the same files or make conflicting decisions.
6. Choose the lowest-cost model that can reliably perform each task.

Use a concise task graph when dependencies matter:

```text
T1: Define shared contract                         orchestrator
T2: Backend implementation          <- T1          worker
T3: Frontend implementation         <- T1          worker
T4: Independent security review     <- T1          bounded worker
T5: Integration and verification    <- T2+T3+T4    orchestrator
```

Parallelize only tasks whose inputs are already stable. If two tasks depend on the same API, schema, type, config, or shared utility, define that boundary first and give every agent the same authoritative description.

## Runtime and model routing

Choose by reasoning complexity, not by line count.

### Google Antigravity profile

The main conversation is the orchestrator and must run on one of:

- **Gemini 3.1 Pro High**
- **Claude Opus 4.6 (Thinking)**

The user selects the main reasoning model in Antigravity's model selector. A skill cannot truthfully claim to have changed the active main model. If the active model is neither option and the task contains architectural or security decisions, tell the user which orchestrator model is required before making those decisions.

Use **Gemini 3.8 Flash** for delegated execution. With Antigravity's sub-agent API:

1. Prefer a reusable or transient worker configured with `model: flash`.
2. Use `define_subagent` when a Flash worker must be created, then use `invoke_subagent` for each independent task.
3. Give each invocation a clean, self-contained brief because Antigravity sub-agents do not inherit the parent's conversation history.
4. Choose the workspace mode deliberately: use an inherited/shared workspace only for disjoint file ownership; use an isolated branch/worktree when edits could collide.
5. Keep permissions and tools minimal for the assignment. Do not grant deployment, secret, destructive, browser, or external-write capabilities unless the user's task requires and authorizes them.

Gemini 3.8 Flash may perform:

- straightforward implementation or CRUD against a frozen contract
- mechanical refactoring and repetitive changes
- tests, types, formatting, and documentation
- repository search and tracing direct usages
- bounded investigation whose decision rules are already supplied
- fixing obvious compiler or linter errors

Gemini 3.8 Flash must escalate instead of deciding architecture, trust boundaries, public contracts, database schemas, concurrency design, or ambiguous product requirements.

Do not use Antigravity's `/teamwork-preview` merely because it exists. Use it only when the user requested a long-running agent team and the work is large enough to justify platform-managed teamwork. Normal parallel tasks should use focused asynchronous sub-agents.

### Claude Code profile

Run the main conversation on the versionless **`opus`** model-family alias. Delegate bounded implementation and investigation to sub-agents using the versionless **`sonnet`** alias.

Do not put full Claude model IDs or version numbers in this skill, task briefs, or project sub-agent definitions. The `opus` and `sonnet` aliases intentionally follow the newest version permitted by the user's Claude Code configuration.

The user selects the main model, for example through Claude Code's model selector or `--model opus`. The skill cannot truthfully claim to have switched the active main model. If the main conversation is not running on Opus and the task requires architecture, security-boundary, public-contract, schema, or final integration decisions, tell the user to switch to the `opus` alias before making those decisions.

When delegating in Claude Code:

1. Pass `model: sonnet` for each invocation or use a project sub-agent whose frontmatter declares `model: sonnet`.
2. Give every sub-agent a self-contained task brief. A normal Claude Code sub-agent starts with an isolated context and does not inherit the main conversation history.
3. Start independent sub-agents concurrently. Keep dependent tasks sequential until their shared contract is frozen.
4. Use background execution when the orchestrator can continue useful independent work. Use foreground execution when the next decision requires the result immediately.
5. Use `isolation: worktree` when workers could collide in the same checkout. Use the shared checkout only with explicit, disjoint file ownership.
6. Grant only the tools needed for the assignment and preserve the user's approval boundaries.

Claude Sonnet may handle both clear execution and bounded multi-file investigation when the contract, constraints, and escalation conditions are explicit. It must escalate architectural ambiguity, trust-boundary changes, public API/schema changes, and conflicts with the established design back to Opus.

### Codex compatibility profile

When the host is Codex rather than Antigravity:

- keep architecture, ambiguous requirements, trust boundaries, shared contracts, and final integration in the primary high-reasoning agent
- use `gpt-5.6-luna` for clear, well-specified execution
- use `gpt-5.6-terra` only for bounded complexity that genuinely needs investigation

Codex model names are a compatibility mapping, not requirements for Antigravity.

### Clear execution tier

Use Gemini 3.8 Flash in Antigravity, Sonnet in Claude Code, or Luna in Codex for work whose decisions are already specified, such as:

- straightforward implementation or CRUD
- mechanical refactoring and repetitive changes
- simple tests, types, formatting, and documentation
- repository search and tracing direct usages
- fixing obvious compiler or linter errors

Do not ask the execution tier to make architectural, security-boundary, public-contract, or data-model decisions.

### Bounded complexity tier

In Antigravity, keep this tier on Gemini 3.8 Flash but give it narrower scope, explicit decision rules, and an escalation condition. In Claude Code, use Sonnet. In Codex, use Terra. Appropriate work includes:

- multi-file debugging or non-trivial refactoring
- integration tests
- dependency or API migration with a stable target contract
- performance investigation
- bounded correctness or security review

Tell the worker to escalate if requirements are ambiguous, the public contract must change, or several architecturally plausible solutions exist.

### Orchestrator tier

Keep these decisions in Gemini 3.1 Pro or Claude Opus 4.6 on Antigravity, the `opus` alias on Claude Code, or the primary high-reasoning model on Codex:

- architecture and major redesign
- ambiguous requirements
- trust boundaries and security architecture
- public API, shared contract, database schema, or concurrency design
- difficult root-cause analysis spanning unrelated modules
- conflicts between sub-agent outputs
- final integration and acceptance

When choosing between a worker and the orchestrator, use this ordered test:

1. If the outcome changes a public contract or database schema, keep it in the primary agent.
2. If multiple viable fixes have long-term architectural consequences, keep it in the primary agent.
3. If the work is fully bounded to one subsystem and its contract is stable, a worker is appropriate.
4. A bug in a specific security function can go to a worker with explicit invariants; deciding where the trust boundary belongs stays in the orchestrator.

If a task cannot be fully specified and bounded before delegation, keep it in the orchestrator until the uncertainty is resolved.

## When delegation is worthwhile

Delegate when at least one applies:

- two or more independent work streams can run in parallel
- a large repository can be explored by distinct, non-overlapping areas
- repetitive implementation follows one stable pattern
- a bounded problem benefits from isolated investigation
- independent correctness, security, or test reviews add meaningful confidence

Avoid delegation when:

- the task is tiny or highly sequential
- delegation overhead exceeds the likely work
- agents would repeatedly edit the same files
- a sub-agent needs nearly the entire primary context
- the task requires one coherent reasoning chain or continuous back-and-forth

As a default heuristic, do not delegate work expected to take less than roughly 15 minutes or touch fewer than about three files. Treat this as guidance, not a hard rule; risk and reasoning complexity take priority.

## Task brief contract

Every delegated task must state:

1. objective
2. relevant files or directories
3. necessary context and frozen interfaces
4. exact requirements
5. constraints and prohibited changes
6. definition of done
7. required report and verification evidence

Use this template:

```text
## Task
<one-sentence objective>

## Context
<why this task exists and the stable decisions it must follow>

## Relevant files
- path/to/file

## Requirements
1. ...

## Constraints
- Do not modify unrelated modules.
- Preserve public APIs unless the task explicitly changes them.
- Follow existing project conventions.
- Escalate instead of making architectural assumptions.

## Definition of done
- Implementation is complete.
- Relevant tests are added or updated and pass.
- No unrelated changes are introduced.

## Report
Return files changed, implementation summary, tests run, and remaining concerns.
```

Give agents the minimum sufficient context. Prefer file paths, relevant signatures, and a distilled contract over forwarding the entire conversation. If a downstream task depends on an earlier agent, pass only the resulting decisions and interfaces, not the earlier reasoning trace.

## Collision control

Before spawning, inspect active agents and the dirty working tree. Assign disjoint ownership where possible:

```text
Agent A -> server module
Agent B -> web module
Agent C -> independent review, no edits
```

If two tasks must change the same central file, run them sequentially or have the primary agent own that file. Tell every agent that the workspace is shared and that existing changes belong to the user or other agents.

Prefer a few meaningful tasks over many tiny tasks. Do not delegate single-line edits, isolated renames, or trivial imports as separate assignments.

## Integration and verification

Treat agent reports as evidence, not truth. After every delegated implementation:

1. inspect the actual diff and affected files
2. check the result against the original requirement and frozen contracts
3. run relevant tests, type checks, and linting yourself when feasible
4. check for unrelated changes, generated artifacts, or accidental API/config changes
5. resolve naming, error handling, and architectural inconsistencies

The primary agent owns the final integration decision and must not report success based only on a sub-agent's claim.

## Escalation and failure handling

Sub-agents must stop and report when they encounter an architectural choice, ambiguous requirement, public-contract change, security-boundary decision, or conflict with established design.

When a task fails:

1. Diagnose whether the brief was incomplete, a real blocker exists, or verification disproved the result.
2. Retry at most once with a corrected brief when missing context caused the failure.
3. If the same tier fails again, move the task to the orchestrator. In Claude Code this means Sonnet to Opus. In Codex, a Luna task may first move to Terra when the issue is bounded investigation rather than architecture.
4. If verification disproves a claimed fix, inspect the diff directly rather than asking the same agent to self-certify again.
5. Let unrelated parallel streams continue.

When agents conflict, the primary agent reads both artifacts and verifies facts against the repository. Resolve factual disagreements with evidence; retain genuine design trade-offs as primary-agent decisions.

## Final rule

Optimize for useful, correct work rather than agent count:

> The orchestrator thinks, freezes contracts, integrates, and verifies. Gemini 3.8 Flash executes bounded work in Antigravity, Sonnet does so in Claude Code, and Luna or Terra performs the equivalent role in Codex. Use the smallest number of agents needed for a correct result.
