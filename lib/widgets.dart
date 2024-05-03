import 'package:flutter/material.dart';

class WidgetWithTitle extends StatelessWidget {
  const WidgetWithTitle({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      child,
    ],
  );
}
