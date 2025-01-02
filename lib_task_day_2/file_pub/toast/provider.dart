import 'package:flutter/material.dart';
import 'styles.dart';
import 'type.dart';

class ToastProvider extends InheritedWidget {
  final void Function(NotificationType) showToast;
  final void Function(int) deleteToast;
  final void Function(ToastStyle) setStyle;

  const ToastProvider({
    super.key,
    required this.setStyle,
    required this.showToast,
    required this.deleteToast,
    required super.child,
  });

  static ToastProvider of(BuildContext context) {
    ToastProvider provider = context.dependOnInheritedWidgetOfExactType()!;
    print("ToastProvider trouvé: $provider");
    return provider;
  }

  @override
  bool updateShouldNotify(ToastProvider oldWidget) => false;
}
