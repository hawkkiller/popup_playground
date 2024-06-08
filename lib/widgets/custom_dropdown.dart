import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/popup.dart';

final class CustomDropdownEntry<T> {
  final T value;
  final String label;

  const CustomDropdownEntry(this.value, this.label);
}

/// Dropdown implementation using [Popup]
class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    required this.items,
    required this.activeItem,
    required this.onChanged,
    super.key,
  });

  final List<CustomDropdownEntry<T>> items;
  final CustomDropdownEntry<T>? activeItem;
  final ValueChanged<CustomDropdownEntry<T>>? onChanged;

  @override
  Widget build(BuildContext context) => Popup(
        child: (context, controller) => TapRegion(
          debugLabel: 'CustomDropdown',
          groupId: controller,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: onChanged == null
                  ? null
                  : () {
                      controller.isShowing ? controller.hide() : controller.show();
                    },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: activeItem == null ? const Text('Select an item') : Text(activeItem!.label),
              ),
            ),
          ),
        ),
        follower: (context, controller) => PopupFollower(
          onDismiss: controller.hide,
          tapRegionGroupId: controller,
          child: IntrinsicWidth(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: items.mapIndexed(
                  (index, item) => ListTile(
                    autofocus: activeItem == null ? index == 0 : item == activeItem,
                    title: Text(item.label),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    onTap: () {
                      onChanged?.call(item);
                      controller.hide();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

extension _MapIndexed<T> on List<T> {
  List<R> mapIndexed<R>(R Function(int index, T item) f) {
    var i = 0;
    return map((e) => f(i++, e)).toList();
  }
}
