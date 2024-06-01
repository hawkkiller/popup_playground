import 'package:flutter/material.dart';

class MenuAnchorShowcase extends StatefulWidget {
  const MenuAnchorShowcase({super.key});

  @override
  State<MenuAnchorShowcase> createState() => _MenuAnchorShowcaseState();
}

class _MenuAnchorShowcaseState extends State<MenuAnchorShowcase> {
  final MenuController _styledController = MenuController();

  void _onItemPressed(String item) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text('Item $item pressed'),
        duration: const Duration(seconds: 1),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(
      children: [
        Text('MenuAnchor', style: textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: 'The ',
            style: textTheme.bodyLarge,
            children: [
              TextSpan(
                text: 'MenuAnchor',
                style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' is a Material 3 widget that allows you to anchor a menu to an element. ',
              ),
              const TextSpan(
                text: 'It is quite customizable and can be used '
                    'to create dropdowns, context menus, and submenus. ',
              ),
            ],
          ),
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: [
            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => _onItemPressed('1'),
                  child: const Text('Item 1'),
                ),
                MenuItemButton(
                  onPressed: () => _onItemPressed('2'),
                  child: const Text('Item 2'),
                ),
                MenuItemButton(
                  onPressed: () => _onItemPressed('3'),
                  child: const Text('Item 3'),
                ),
              ],
              builder: (context, controller, child) => FilledButton.icon(
                onPressed: controller.open,
                icon: const Icon(Icons.menu),
                label: const Text('Show Standard Menu'),
              ),
            ),
            MenuAnchor(
              controller: _styledController,
              style: MenuStyle(
                elevation: const WidgetStatePropertyAll(8),
                backgroundColor: WidgetStatePropertyAll(colorScheme.tertiaryContainer),
              ),
              menuChildren: [
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                  onTap: () {
                    _styledController.close();
                    _onItemPressed('Profile');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    _styledController.close();
                    _onItemPressed('Settings');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    _styledController.close();
                    _onItemPressed('Logout');
                  },
                ),
              ],
              builder: (context, controller, child) => FilledButton.icon(
                onPressed: controller.open,
                icon: const Icon(Icons.menu),
                label: const Text('Show Styled Menu'),
              ),
            ),
            MenuAnchor(
              menuChildren: [
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      child: const Text('Subitem 1'),
                      onPressed: () => _onItemPressed('Subitem 1'),
                    ),
                    MenuItemButton(
                      child: const Text('Subitem 2'),
                      onPressed: () => _onItemPressed('Subitem 2'),
                    ),
                  ],
                  child: const Text('Submenu'),
                ),
                MenuItemButton(
                  child: const Text('Item 1'),
                  onPressed: () => _onItemPressed('1'),
                ),
                MenuItemButton(
                  child: const Text('Item 2'),
                  onPressed: () => _onItemPressed('2'),
                ),
              ],
              builder: (context, controller, child) => FilledButton.icon(
                onPressed: controller.open,
                icon: const Icon(Icons.menu),
                label: const Text('Show Menu with Submenu'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
