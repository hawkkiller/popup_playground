import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popup_playground/countries.dart';

class MenuAnchorShowcase extends StatefulWidget {
  const MenuAnchorShowcase({super.key});

  @override
  State<MenuAnchorShowcase> createState() => _MenuAnchorShowcaseState();
}

class _MenuAnchorShowcaseState extends State<MenuAnchorShowcase> {
  final MenuController _styledController = MenuController();
  final MenuController _customController = MenuController();
  final MenuController _countryController = MenuController();

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
                    'to create dropdowns, context menus, and more. ',
              ),
              const TextSpan(
                text: 'Though it is possible to put only one item inside the menu and use it '
                    'as a custom popup, it is not a recommended way to use this widget.',
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
              controller: _customController,
              style: MenuStyle(
                shape: WidgetStatePropertyAll(
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
            MenuAnchor(
              controller: _countryController,
              style: MenuStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              menuChildren: [
                _CountryMenu(controller: _countryController),
              ],
              builder: (context, controller, child) => FilledButton.icon(
                onPressed: controller.open,
                icon: const Icon(Icons.flag_outlined),
                label: const Text('Show Country Picker'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CountryMenu extends StatefulWidget {
  const _CountryMenu({required this.controller});

  final MenuController controller;

  @override
  State<_CountryMenu> createState() => _CountryMenuState();
}

class _CountryMenuState extends State<_CountryMenu> {
  final _filter = TextEditingController();

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: SizedBox(
          width: min(MediaQuery.sizeOf(context).width - 50, 200),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _filter,
                  decoration: const InputDecoration(
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Start typing country..',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: _filter,
                builder: (context, value, _) {
                  final countries = countryList.where(
                    (country) => country.name.toLowerCase().contains(value.text.toLowerCase()),
                  );
                  return SizedBox(
                    height: min(countries.length * 48.0, 200),
                    child: ListView.builder(
                      clipBehavior: Clip.antiAlias,
                      itemCount: countries.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(countries.elementAt(index).name),
                        onTap: () {
                          widget.controller.close();
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Country selected: ${countries.elementAt(index).name}',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
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
