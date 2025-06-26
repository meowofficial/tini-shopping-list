import 'package:flutter/material.dart';

class CoreTheme extends InheritedTheme {
  CoreTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color primaryContrastingColor,
    required super.child,
    super.key,
  }) : _brightness = brightness,
       _primaryColor = primaryColor,
       _primaryContrastingColor = primaryContrastingColor {
    switch (brightness) {
      case Brightness.dark:
        _data = CoreThemeData.dark(
          primaryColor: primaryColor,
          primaryContrastingColor: primaryContrastingColor,
        );

      case Brightness.light:
        _data = CoreThemeData.light(
          primaryColor: primaryColor,
          primaryContrastingColor: primaryContrastingColor,
        );
    }
  }

  final Brightness _brightness;
  final Color _primaryColor;
  final Color _primaryContrastingColor;
  late final CoreThemeData _data;

  static CoreThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<CoreTheme>()!;
    return inheritedTheme._data;
  }

  static Brightness brightnessOf(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<CoreTheme>()!;
    return inheritedTheme._data.brightness;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme = context.findAncestorWidgetOfExactType<CoreTheme>();

    if (identical(this, ancestorTheme)) {
      return child;
    }

    return CoreTheme(
      brightness: _brightness,
      primaryColor: _primaryColor,
      primaryContrastingColor: _primaryContrastingColor,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(CoreTheme oldWidget) {
    return _brightness != oldWidget._brightness ||
        _primaryColor != oldWidget._primaryColor ||
        _primaryContrastingColor != oldWidget._primaryContrastingColor;
  }
}

class CoreThemeData {
  const CoreThemeData._internal({
    required this.brightness,
    required this.primaryColor,
    required this.primaryContrastingColor,
  });

  factory CoreThemeData.light({
    required Color primaryColor,
    required Color primaryContrastingColor,
  }) {
    return CoreThemeData._internal(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primaryContrastingColor: primaryContrastingColor,
    );
  }

  factory CoreThemeData.dark({
    required Color primaryColor,
    required Color primaryContrastingColor,
  }) {
    return CoreThemeData._internal(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primaryContrastingColor: primaryContrastingColor,
    );
  }

  final Brightness brightness;
  final Color primaryColor;
  final Color primaryContrastingColor;
}
