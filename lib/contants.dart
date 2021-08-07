import 'package:flutter/material.dart';

final Color btnColor = Colors.grey.shade200;
final Color bgColor = Colors.white;

final Color primaryTextColor = Color(0xff181818);
final Color secTextColor = Colors.white;

final Color accentColor = Color(0xffF9A826);

final MaterialColor swatch = MaterialColor(
  0xffF9A826,
  {
    50: accentColor.withOpacity(0.1),
    100: accentColor.withOpacity(0.2),
    200: accentColor.withOpacity(0.3),
    300: accentColor.withOpacity(0.4),
    400: accentColor.withOpacity(0.5),
    500: accentColor.withOpacity(0.6),
    600: accentColor.withOpacity(0.7),
    700: accentColor.withOpacity(0.8),
    800: accentColor.withOpacity(0.9),
    900: accentColor.withOpacity(1.0),
  },
);
