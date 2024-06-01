import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/showcase_widgets.dart';

class DropdownMenuShowcase extends StatelessWidget {
  const DropdownMenuShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(children: [
      Text('DropdownMenu', style: textTheme.headlineLarge),
      const SizedBox(height: 8),
      Text(
        'The DropdownMenu is a widget in Material 3 that displays a dropdown menu.',
        style: textTheme.bodyLarge,
      ),
      const SizedBox(height: 16),
      const Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          WidgetWithTitle(
            title: 'Default',
            child: DropdownMenu(
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Item 1', value: '1'),
                DropdownMenuEntry(label: 'Item 2', value: '2'),
              ],
            ),
          ),
          WidgetWithTitle(
            title: 'With filter',
            child: DropdownMenu(
              enableFilter: true,
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Aaaaaa', value: '1'),
                DropdownMenuEntry(label: 'Bbbbbb', value: '2'),
                DropdownMenuEntry(label: 'Cccccc', value: '3'),
              ],
            ),
          ),
          WidgetWithTitle(
            title: 'With label',
            child: DropdownMenu(
              label: Text('Select an item'),
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Aaaaaa', value: '1'),
                DropdownMenuEntry(label: 'Bbbbbb', value: '2'),
                DropdownMenuEntry(label: 'Cccccc', value: '3'),
              ],
            ),
          ),
          WidgetWithTitle(
            title: 'With leading icon',
            child: DropdownMenu(
              leadingIcon: Icon(Icons.search),
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Aaaaaa', value: '1'),
                DropdownMenuEntry(label: 'Bbbbbb', value: '2'),
                DropdownMenuEntry(label: 'Cccccc', value: '3'),
              ],
            ),
          ),
          WidgetWithTitle(
            title: 'Without focus on tap',
            child: DropdownMenu(
              requestFocusOnTap: false,
              leadingIcon: Icon(Icons.search),
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Aaaaaa', value: '1'),
                DropdownMenuEntry(label: 'Bbbbbb', value: '2'),
                DropdownMenuEntry(label: 'Cccccc', value: '3'),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
