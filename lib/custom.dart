import 'package:flutter/material.dart';

class CustomPopupsShowcase extends StatefulWidget {
  const CustomPopupsShowcase({super.key});

  @override
  State<CustomPopupsShowcase> createState() => _CustomPopupsShowcaseState();
}

class _CustomPopupsShowcaseState extends State<CustomPopupsShowcase> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(
      children: [
        Text('Custom Popups', style: textTheme.headlineLarge),
        const SizedBox(height: 8),
      ],
    );
  }
}
