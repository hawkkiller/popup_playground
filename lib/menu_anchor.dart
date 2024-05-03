import 'dart:math';

import 'package:flutter/material.dart';

class MenuAnchorShowcase extends StatefulWidget {
  const MenuAnchorShowcase({super.key});

  @override
  State<MenuAnchorShowcase> createState() => _MenuAnchorShowcaseState();
}

class _MenuAnchorShowcaseState extends State<MenuAnchorShowcase> {
  late final MenuController _styledController;
  late final MenuController _customController;

  void _onItemPressed(String item) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text('Item $item pressed'),
        duration: const Duration(seconds: 1),
      ));
  }

  @override
  void initState() {
    _styledController = MenuController();
    _customController = MenuController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(
      children: [
        Text('MenuAnchor', style: textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(
          'MenuAnchor is a Material You widget that renders an anchored menu.',
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
                elevation: const MaterialStatePropertyAll(8),
                backgroundColor: MaterialStatePropertyAll(colorScheme.tertiaryContainer),
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
              controller: _customController,
              style: MenuStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              menuChildren: [
                _CustomMenu(controller: _customController),
              ],
              builder: (context, controller, child) => FilledButton.icon(
                onPressed: controller.open,
                icon: const Icon(Icons.menu),
                label: const Text('Show Custom Menu'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CustomMenu extends StatefulWidget {
  const _CustomMenu({required this.controller});

  final MenuController controller;

  @override
  State<_CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<_CustomMenu> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: SizedBox(
          width: min(MediaQuery.sizeOf(context).width - 50, 200),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu Header',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: widget.controller.close,
                    ),
                  ],
                ),
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Enter text',
                    helperText: 'Enter some text',
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _textController,
                  builder: (context, value, child) => Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: value.text.isEmpty
                          ? null
                          : () {
                              widget.controller.close();
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(SnackBar(
                                  content: Text('Text submitted: ${value.text}'),
                                  duration: const Duration(seconds: 1),
                                ));
                            },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
