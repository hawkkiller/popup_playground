import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popup_playground/countries.dart';
import 'package:popup_playground/widgets.dart';

class DropdownMenuShowcase extends StatefulWidget {
  const DropdownMenuShowcase({super.key});

  @override
  State<DropdownMenuShowcase> createState() => _DropdownMenuShowcaseState();
}

class _DropdownMenuShowcaseState extends State<DropdownMenuShowcase> {
  final _entries = const [
    DropdownMenuEntry(
      value: '1',
      label: 'Item 1',
    ),
    DropdownMenuEntry(
      value: '2',
      label: 'Item 2',
    ),
    DropdownMenuEntry(
      value: '3',
      label: 'Item 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(
      children: [
        Text('DropdownMenu', style: textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: 'The ',
            style: textTheme.bodyLarge,
            children: [
              TextSpan(
                text: 'DropdownMenu',
                style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                  text: ' is a widget in Material 3 that substitutes the DropdownButton widget. '),
              const TextSpan(
                text: 'It allows more customization options and a better user experience. ',
              ),
              const TextSpan(
                text: 'It uses the MenuAnchor widget under the hood. ',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: [
            WidgetWithTitle(
              title: 'Default',
              child: DropdownMenu(dropdownMenuEntries: _entries),
            ),
            WidgetWithTitle(
              title: 'With icon',
              child: DropdownMenu(
                dropdownMenuEntries: _entries,
                leadingIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            WidgetWithTitle(
              title: 'With text',
              child: DropdownMenu(
                dropdownMenuEntries: _entries,
                hintText: 'Select an item',
                helperText: 'This is a helper text',
                width: 180,
              ),
            ),
            WidgetWithTitle(
              title: 'Custom Style',
              child: DropdownMenu(
                dropdownMenuEntries: _entries,
                leadingIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                hintText: 'Select an item',
                helperText: 'This is a helper text',
                width: 200,
                initialSelection: _entries[1].value,
                label: const Text('Label'),
                inputDecorationTheme: const InputDecorationTheme(filled: true),
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  side: MaterialStatePropertyAll(
                    BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ),
            WidgetWithTitle(
              title: 'With error',
              child: DropdownMenu(
                dropdownMenuEntries: _entries,
                hintText: 'Select an item',
                errorText: 'This is an error text',
                width: 180,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
