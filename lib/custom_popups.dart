import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/popup.dart';
import 'package:popup_playground/widgets/showcase_widgets.dart';

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
            children: const [
              TextSpan(
                text: "This section showcases custom popups I've built using "
                    "Popup widget. ",
              ),
              TextSpan(
                text: "The Popup widget is a simple widget "
                    "that allows you to show a popup anchored to a widget.",
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Wrap(
          runSpacing: 16,
          spacing: 16,
          children: [
            WidgetWithTitle(
              title: 'Simple Popup',
              child: _SimplePopup(),
            ),
            WidgetWithTitle(
              title: 'Show dismissible popup',
              child: _DismissiblePopup(),
            ),
            WidgetWithTitle(
              title: 'Show popup with custom anchor',
              child: _CustomAnchorPopup(),
            ),
          ],
        ),
      ],
    );
  }
}

class _SimplePopup extends StatelessWidget {
  const _SimplePopup();

  @override
  Widget build(BuildContext context) {
    return Popup(
      child: (context, controller) => FilledButton(
        onPressed: () => controller.show(),
        child: const Text('Show Simple Popup'),
      ),
      follower: (context, controller) => SizedBox(
        width: 200,
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
    );
  }
}

class _CustomAnchorPopup extends StatelessWidget {
  const _CustomAnchorPopup();

  @override
  Widget build(BuildContext context) => Popup(
        targetAnchor: Alignment.centerRight,
        followerAnchor: Alignment.centerLeft,
        child: (context, controller) => FilledButton(
          onPressed: () => controller.show(),
          child: const Text('Show Popup with Custom Anchor'),
        ),
        follower: (context, controller) => PopupFollower(
          onDismiss: () => controller.hide(),
          child: SizedBox(
            width: 200,
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
      );
}

class _DismissiblePopup extends StatelessWidget {
  const _DismissiblePopup();

  @override
  Widget build(BuildContext context) => Popup(
        child: (context, controller) => TapRegion(
          groupId: 'ClosesPopup',
          child: FilledButton(
            onPressed: () => controller.show(),
            child: const Text('Show Dismissible Popup'),
          ),
        ),
        follower: (context, controller) => PopupFollower(
          tapRegionGroupId: 'ClosesPopup',
          onDismiss: () => controller.hide(),
          child: SizedBox(
            width: 200,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    title: const Text('Item 1'),
                    onTap: () => controller.hide(),
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () => controller.hide(),
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    title: const Text('Item 3'),
                    onTap: () => controller.hide(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
