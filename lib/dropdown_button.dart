import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/showcase_widgets.dart';

class DropdownButtonShowcase extends StatefulWidget {
  const DropdownButtonShowcase({super.key});

  @override
  State<DropdownButtonShowcase> createState() => _DropdownButtonShowcaseState();
}

class _DropdownButtonShowcaseState extends State<DropdownButtonShowcase> {
  String? _dropdown1Value;
  String? _dropdown2Value;
  String? _dropdown3Value;
  String? _dropdown4Value;
  String? _dropdown5Value;

  final _items = const [
    DropdownMenuItem(
      value: '1',
      child: Text('Item 1'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Item 2'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Item 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverList.list(children: [
      Text('DropdownButton', style: textTheme.headlineLarge),
      const SizedBox(height: 8),
      Text.rich(
        TextSpan(
          text: 'The ',
          style: textTheme.bodyLarge,
          children: [
            TextSpan(
              text: 'DropdownButton',
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
                text: ' is a widget in Material 2 designed to display a dropdown button. '),
            const TextSpan(
              text: 'It allows users to choose an item from a list of options. ',
            ),
            const TextSpan(
              text: 'However, it offers limited customization options.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Wrap(runSpacing: 16, spacing: 16, children: [
        WidgetWithTitle(
          title: 'Default',
          child: DropdownButton<String>(
            items: _items,
            value: _dropdown1Value,
            onChanged: (value) => setState(
              () => _dropdown1Value = value,
            ),
          ),
        ),
        WidgetWithTitle(
          title: 'With hint',
          child: DropdownButton<String>(
            items: _items,
            value: _dropdown2Value,
            onChanged: (value) => setState(
              () => _dropdown2Value = value,
            ),
            hint: const Text('Select an item'),
          ),
        ),
        WidgetWithTitle(
          title: 'Disabled',
          child: DropdownButton<String>(
            items: _items,
            value: _dropdown3Value,
            onChanged: null,
          ),
        ),
        WidgetWithTitle(
          title: 'With icon',
          child: DropdownButton<String>(
            items: _items,
            value: _dropdown4Value,
            onChanged: (value) => setState(
              () => _dropdown4Value = value,
            ),
            icon: const Icon(Icons.arrow_drop_down_circle_sharp),
          ),
        ),
        WidgetWithTitle(
          title: 'Custom style',
          child: DropdownButton<String>(
            items: _items,
            value: _dropdown5Value,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            dropdownColor: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            focusColor: Colors.transparent,
            underline: const SizedBox.shrink(),
            hint: const Text('Select an item'),
            icon: const Icon(Icons.arrow_drop_down_rounded),
            onChanged: (value) => setState(() => _dropdown5Value = value),
          ),
        ),
      ]),
    ]);
  }
}
