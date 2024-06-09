import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/custom_dropdown.dart';
import 'package:popup_playground/widgets/custom_tooltip.dart';
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
        Text(
          'This section showcases custom popups that can be created using the Popup widget. '
          'Popup is a versatile widget that can be used to create custom popups with ease. ',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Dropdown',
              description: 'Popup that shows a list of items when tapped. '
                  'The dropdown is shown below the target widget if there is enough space.',
              expanded: expanded,
              child: const _CustomDropdown(),
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
              description: 'Popup that is shown on the right side of a button.',
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
              title: 'Menu with Submenus',
              description: 'A popup that shows a menu with a submenu. '
                  'The submenu is shown when hovering over the menu item.',
              expanded: expanded,
              child: const MenuWithSubmenuPopup(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 700,
            child: WidgetWithDescription(
              title: 'Tooltip',
              description: 'An animated tooltip that is shown when hovering over an icon.',
              expanded: expanded,
              child: const TooltipPopup(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Possibilities are endless with the Popup widget.',
          style: textTheme.titleLarge,
        ),
      ],
    );
  }
}

class _CustomDropdown extends StatefulWidget {
  const _CustomDropdown();

  @override
  State<_CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<_CustomDropdown> {
  static final items = List.generate(
    5,
    (index) => CustomDropdownEntry(index, 'Item $index'),
  );

  CustomDropdownEntry? value;

  @override
  Widget build(BuildContext context) => CustomDropdown(
        items: items,
        activeItem: value,
        onChanged: (entry) => setState(() => value = entry),
      );
}

class AnimatedTooltip extends StatefulWidget {
  const AnimatedTooltip({super.key});

  @override
  State<AnimatedTooltip> createState() => _AnimatedTooltipState();
}

class _AnimatedTooltipState extends State<AnimatedTooltip> with SingleTickerProviderStateMixin {
  final popupController = OverlayPortalController();
  late final _animationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  void _show() {
    _animationController.forward();
    popupController.show();
  }

  void _hide() {
    _animationController.reverse().whenCompleteOrCancel(() {
      popupController.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Popup(
      controller: popupController,
      targetAnchor: Alignment.bottomCenter,
      followerAnchor: Alignment.topCenter,
      child: (context, controller) => MouseRegion(
        onEnter: (_) => _show(),
        onExit: (_) => _hide(),
        child: TapRegion(
          groupId: 'tooltip',
          child: IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => controller.isShowing ? _hide() : _show(),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      follower: (context, controller) => PopupFollower(
        tapRegionGroupId: 'tooltip',
        onDismiss: () => _hide(),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => FadeTransition(
            opacity: _animationController,
            child: SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TooltipPopup extends StatelessWidget {
  const TooltipPopup({super.key});

  @override
  Widget build(BuildContext context) => CustomTooltip(
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        child: Icon(Icons.info, color: Theme.of(context).colorScheme.secondary),
      );
}

class _CustomAnchorPopup extends StatelessWidget {
  const _CustomAnchorPopup();

  @override
  Widget build(BuildContext context) => Popup(
        targetAnchor: Alignment.centerRight,
        followerAnchor: Alignment.centerLeft,
        child: (context, controller) => FilledButton(
          onPressed: controller.show,
          child: const Text('Show Popup with Custom Anchor'),
        ),
        follower: (context, controller) => PopupFollower(
          onDismiss: controller.hide,
          child: SizedBox(
            width: 150,
            child: Card(
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
