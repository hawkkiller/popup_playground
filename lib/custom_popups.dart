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
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Menu with Submenus',
              description: 'A popup that shows a menu with a submenu. '
                  'The submenu is shown when hovering over the menu item.',
              expanded: expanded,
              child: const MenuWithSubmenuPopup(),
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
        child: (context, controller) => FilledButton(
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
        child: (context, controller) => TapRegion(
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
        child: (context, controller) => SizedBox(
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
                  height: 150,
                  child: Card(
                    child: Visibility(
                      visible: filteredCountries.isNotEmpty,
                      replacement: const Center(
                        child: Text('No countries found ☹️'),
                      ),
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
                ),
              );
            }),
      );
}

class MenuWithSubmenuPopup extends StatelessWidget {
  const MenuWithSubmenuPopup({super.key});

  @override
  Widget build(BuildContext context) => Popup(
        flip: false,
        follower: (context, controller) => _MenuItemPopup(controller: controller),
        child: (context, controller) => TapRegion(
          groupId: 'menupopup',
          child: FilledButton(
            onPressed: controller.show,
            child: const Text('Show Menu'),
          ),
        ),
      );
}

class _MenuItemPopup extends StatelessWidget {
  const _MenuItemPopup({
    required this.controller,
  });

  final OverlayPortalController controller;

  @override
  Widget build(BuildContext context) => PopupFollower(
        constraints: BoxConstraints.loose(const Size(200, 200)),
        tapRegionGroupId: 'menupopup',
        onDismiss: controller.hide,
        child: const Card.filled(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MenuPopupSection(),
              _MenuPopupSection(),
              _MenuPopupSection(),
            ],
          ),
        ),
      );
}

class _MenuPopupSection extends StatefulWidget {
  const _MenuPopupSection();

  @override
  State<_MenuPopupSection> createState() => _MenuPopupSectionState();
}

class _MenuPopupSectionState extends State<_MenuPopupSection> {
  bool isMenuItemHovered = false;
  bool isSubmenuHovered = false;

  @override
  Widget build(BuildContext context) {
    return Popup(
      targetAnchor: Alignment.centerRight,
      followerAnchor: Alignment.centerLeft,
      follower: (context, controller) => MouseRegion(
        onEnter: (_) {
          isMenuItemHovered = true;
          controller.show();
        },
        onExit: (_) {
          isSubmenuHovered = false;
          controller.hide();
        },
        child: _Submenus(
          controller: controller,
          options: const [
            'Submenu Item',
            'Submenu Item',
            'Submenu Item',
          ],
        ),
      ),
      child: (context, controller) => MouseRegion(
        onEnter: (_) {
          isMenuItemHovered = true;
          controller.show();
        },
        onExit: (_) {
          if (!isSubmenuHovered) {
            controller.hide();
          }
        },
        onHover: (_) => controller.show(),
        child: ListTile(
          title: const Text('Menu Item'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
          onTap: controller.show,
        ),
      ),
    );
  }
}

class _Submenus extends StatefulWidget {
  const _Submenus({
    required this.options,
    required this.controller,
  });

  final List<String> options;
  final OverlayPortalController controller;

  @override
  State<_Submenus> createState() => _SubmenusState();
}

class _SubmenusState extends State<_Submenus> {
  void _onPressed() {
    FollowerScope.findRootOf(context)?.controller.dismiss();

    widget.controller.hide();
  }

  @override
  Widget build(BuildContext context) => PopupFollower(
        constraints: BoxConstraints.loose(const Size(200, 200)),
        tapRegionGroupId: 'menupopup',
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final option in widget.options)
                  ListTile(
                    title: Text(option),
                    onTap: _onPressed,
                  ),
              ],
            ),
          ),
        ),
      );
}
