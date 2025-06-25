import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum ScreenLayout {
  phone,
  desktop,
}

class Responsive extends InheritedWidget {
  final ResponsiveData data;

  const Responsive({
    super.key,
    required this.data,
    required super.child,
  });

  static ResponsiveData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Responsive>()!.data;
  }

  static ScreenLayout screenLayoutOf(BuildContext context) {
    return of(context).screenLayout;
  }

  @override
  bool updateShouldNotify(Responsive oldWidget) {
    return data != oldWidget.data;
  }
}

class ResponsiveData extends Equatable {
  const ResponsiveData({
    required this.screenLayout,
    required this.screenSize,
  });

  final ScreenLayout screenLayout;
  final Size screenSize;

  @override
  List<Object?> get props {
    return [
      screenLayout,
      screenSize,
    ];
  }

  ResponsiveData copyWith({
    ScreenLayout Function()? screenLayout,
    Size Function()? screenSize,
  }) {
    return ResponsiveData(
      screenLayout: screenLayout == null ? this.screenLayout : screenLayout(),
      screenSize: screenSize == null ? this.screenSize : screenSize(),
    );
  }
}
