import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/popup.dart';

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
        Text.rich(
          TextSpan(
            style: textTheme.bodyLarge,
            children: [
              TextSpan(
                text: 'Popup ',
                style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'is a custom implementation of a popup that uses the OverlayPortal widget. ',
              ),
              const TextSpan(
                text: 'It allows you to show a popup anchored to a widget. ',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Popup(
          child: (context, controller) => ElevatedButton(
            onPressed: () => controller.show(),
            child: const Text('Show Popup'),
          ),
          follower: (context, controller) => SizedBox(
            width: 300,
            height: 300,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () => controller.hide(),
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () => controller.hide(),
                  ),
                  ListTile(
                    title: const Text('Item 3'),
                    onTap: () => controller.hide(),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 500),
      ],
    );
  }
}
