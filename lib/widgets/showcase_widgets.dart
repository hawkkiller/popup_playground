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

class WidgetWithDescription extends StatelessWidget {
  const WidgetWithDescription({
    required this.title,
    required this.description,
    required this.child,
    required this.expanded,
    super.key,
  });

  final String title;
  final String description;
  final Widget child;
  final bool expanded;

  @override
  Widget build(BuildContext context) => Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (context) {
              if (expanded) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(title, style: Theme.of(context).textTheme.titleMedium),
                          Text(description, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    child,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  child,
                ],
              );
            },
          ),
        ),
      );
}
