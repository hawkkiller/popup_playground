import 'package:flutter/material.dart';
import 'package:popup_playground/countries.dart';
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
    final expanded = MediaQuery.sizeOf(context).width > 700;

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
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Basic popup',
              description: 'The simplest popup that shows a list of '
                  'items without any special behavior.',
              expanded: expanded,
              child: const _BasicPopup(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Dismissible popup',
              description: 'A popup that shows a list of items with a dismiss '
                  'behavior when tapping outside the popup. ',
              expanded: expanded,
              child: const _DismissiblePopup(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Custom Anchor',
              description: 'A popup that is anchored that is shown on the right '
                  'side of the target.',
              expanded: expanded,
              child: const _CustomAnchorPopup(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Country Picker',
              description: 'A custom popup that is used to pick a country. '
                  'It is anchored to a text field and shows a list of countries.',
              expanded: expanded,
              child: const _CountryPickerPopup(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BasicPopup extends StatelessWidget {
  const _BasicPopup();

  @override
  Widget build(BuildContext context) {
    return Popup(
      target: (context, controller) => FilledButton(
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                title: const Text('Item 1'),
                onTap: controller.hide,
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: controller.hide,
              ),
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                title: const Text('Item 3'),
                onTap: controller.hide,
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
        target: (context, controller) => FilledButton(
          onPressed: () => controller.show(),
          child: const Text('Show Popup with Custom Anchor'),
        ),
        follower: (context, controller) => PopupFollower(
          onDismiss: controller.hide,
          child: SizedBox(
            width: 200,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    title: const Text('Item 1'),
                    onTap: controller.hide,
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: controller.hide,
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    title: const Text('Item 3'),
                    onTap: controller.hide,
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
        target: (context, controller) => TapRegion(
          groupId: 'ClosesPopup',
          child: FilledButton(
            onPressed: () => controller.show(),
            child: const Text('Show Dismissible Popup'),
          ),
        ),
        follower: (context, controller) => PopupFollower(
          tapRegionGroupId: 'ClosesPopup',
          onDismiss: controller.hide,
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
                    onTap: controller.hide,
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: controller.hide,
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    title: const Text('Item 3'),
                    onTap: controller.hide,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _CountryPickerPopup extends StatefulWidget {
  const _CountryPickerPopup();

  @override
  State<_CountryPickerPopup> createState() => _CountryPickerPopupState();
}

class _CountryPickerPopupState extends State<_CountryPickerPopup>
    with SingleTickerProviderStateMixin {
  final textController = TextEditingController();
  final popupController = OverlayPortalController();
  final textFieldFocusNode = FocusNode();

  @override
  void initState() {
    textFieldFocusNode.addListener(() {
      if (textFieldFocusNode.hasFocus) {
        popupController.show();
      }
    });

    textController.addListener(() {
      if (!popupController.isShowing) {
        popupController.show();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Popup(
        targetAnchor: Alignment.bottomCenter,
        followerAnchor: Alignment.topCenter,
        enforceLeaderWidth: true,
        controller: popupController,
        target: (context, controller) => SizedBox(
          width: 200,
          child: TextField(
            controller: textController,
            focusNode: textFieldFocusNode,
            decoration: const InputDecoration(
              hintText: 'Select a country',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        follower: (context, controller) => ValueListenableBuilder(
            valueListenable: textController,
            builder: (context, value, _) {
              final filteredCountries = countryList
                  .where(
                    (country) => country.name.toLowerCase().contains(
                          textController.text.toLowerCase(),
                        ),
                  )
                  .toList();
              return PopupFollower(
                onDismiss: controller.hide,
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];

                        return ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          title: Text(country.name),
                          onTap: () {
                            textController.text = country.name;
                            controller.hide();
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
      );
}
