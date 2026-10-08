import 'package:flutter/material.dart';

class AppRadius {
  // Sharp (4–6 dp): Tags, badges, chips
  static const double sharp = 6.0;
  static const BorderRadius sharpBorder = BorderRadius.all(
    Radius.circular(sharp),
  );

  // Subtle (8–10 dp): Inputs, standard buttons, standard cards
  static const double subtle = 10.0;
  static const BorderRadius subtleBorder = BorderRadius.all(
    Radius.circular(subtle),
  );

  // Soft (12–16 dp max): Bottom sheets, dialogs, hero cards
  static const double soft = 16.0;
  static const BorderRadius softBorder = BorderRadius.all(
    Radius.circular(soft),
  );
}
