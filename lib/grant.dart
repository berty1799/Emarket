import 'package:flutter/material.dart';

/// Returns a smooth linear gradient from solid color to transparent
LinearGradient getGradient(Color color) => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        color.withOpacity(0.8), // بداية قوية
        color.withOpacity(0.2), // نهاية ناعمة
      ],
      stops: const [0.0, 1.0],
    );
