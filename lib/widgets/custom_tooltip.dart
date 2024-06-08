import 'package:flutter/material.dart';
import 'package:popup_playground/widgets/popup.dart';

/// A custom tooltip widget that can be used to display a tooltip with custom content
class CustomTooltip extends StatefulWidget {
  const CustomTooltip({
    required this.content,
    required this.child,
    this.animationDuration,
    super.key,
  });

  /// Convenience constructor to create a [CustomTooltip] with a [Text] widget as content
  factory CustomTooltip.text({
    required String text,
    required Widget child,
    Duration? animationDuration,
    Key? key,
  }) =>
      CustomTooltip(
        key: key,
        content: Text(text),
        animationDuration: animationDuration,
        child: child,
      );

  final Widget content;
  final Widget child;
  final Duration? animationDuration;

  @override
  State<CustomTooltip> createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> with SingleTickerProviderStateMixin {
  final overlayController = OverlayPortalController(debugLabel: 'CustomTooltip');
  late final AnimationController _animationController;

  Duration get _animationDuration => widget.animationDuration ?? Durations.medium1;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTooltip oldWidget) {
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = _animationDuration;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Shows popup and sets a timer to hide it after [duration] if it is not null
  void _showPopup([Duration? duration]) {
    overlayController.show();
    _animationController.forward();

    if (duration != null) {
      Future.delayed(duration, _hidePopup).ignore();
    }
  }

  void _hidePopup() {
    _animationController.reverse().whenComplete(overlayController.hide);
  }

  void _togglePopup([Duration? duration]) {
    overlayController.isShowing ? _hidePopup() : _showPopup(duration);
  }

  Widget _buildMobileTooltip(Widget child) => GestureDetector(
        onTap: () => _togglePopup(_animationDuration + const Duration(seconds: 5000)),
        child: child,
      );

  Widget _buildDesktopTooltip(Widget child) => MouseRegion(
        onEnter: (_) => _showPopup(),
        onExit: (_) => _hidePopup(),
        child: child,
      );

  @override
  Widget build(BuildContext context) => Popup(
        controller: overlayController,
        follower: (context, controller) => PopupFollower(
          onDismiss: _hidePopup,
          child: FadeTransition(
            opacity: _animationController,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ),
        child: (context, controller) {
          final platform = Theme.of(context).platform;
          Widget result;

          switch (platform) {
            case TargetPlatform.android:
            case TargetPlatform.iOS:
              result = _buildMobileTooltip(widget.child);
              break;
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.macOS:
            case TargetPlatform.windows:
              result = _buildDesktopTooltip(widget.child);
              break;
          }

          return TapRegion(
            groupId: controller,
            child: result,
          );
        },
      );
}
