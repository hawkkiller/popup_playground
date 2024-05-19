import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popup_playground/widgets/enhanced_composited_transform_follower.dart';
import 'package:popup_playground/widgets/enhanced_composited_transform_target.dart';

/// A function that builds a widget with a controller.
typedef PopupWidgetBuilder = Widget Function(
  BuildContext context,
  OverlayPortalController controller,
);

/// {@template popup}
/// A widget that shows a follower widget relative to a target widget.
///
/// Under the hood, it uses [OverlayPortal] that is a declarative version
/// of [OverlayEntry]. In order to position the follower widget relative to
/// the target widget, it uses [CompositedTransformTarget] and
/// [EnhancedCompositedTransformFollower].
///
/// This widget is useful when you want to show a popup, tooltip, or dropdown
/// relative to a target widget. It also automatically manages the position on
/// the screen and ensures that the follower widget is always visible
/// (i.e. it doesn't overflow the screen) by adjusting the position.
/// {@endtemplate}
class Popup extends StatefulWidget {
  /// Creates a new instance of [Popup].
  ///
  /// {@macro popup}
  const Popup({
    required this.child,
    required this.follower,
    this.edgeInsets = EdgeInsets.zero,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    this.controller,
    super.key,
  });

  /// The target widget that the follower widget is positioned relative to.
  final PopupWidgetBuilder child;

  /// The widget that is positioned relative to the target widget.
  final PopupWidgetBuilder follower;

  /// The alignment of the follower widget relative to the target widget.
  ///
  /// Defaults to [Alignment.topCenter].
  final Alignment followerAnchor;

  /// The alignment of the target widget relative to the follower widget.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final Alignment targetAnchor;

  /// The minimal distance between the follower widget and corners.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets edgeInsets;

  /// The controller that will be used to show/hide the overlay.
  ///
  /// If not provided, a new controller will be created.
  final OverlayPortalController? controller;

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  /// The link between the target widget and the follower widget.
  final _layerLink = EnhancedLayerLink();

  /// The controller that is used to show/hide the overlay.
  late OverlayPortalController portalController;

  @override
  void initState() {
    portalController = widget.controller ?? OverlayPortalController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Popup oldWidget) {
    if (!identical(widget.controller, oldWidget.controller)) {
      portalController = widget.controller ?? OverlayPortalController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => EnhancedCompositedTransformTarget(
        link: _layerLink, // link the target widget to the follower widget.
        child: OverlayPortal(
          controller: portalController,
          child: widget.child(context, portalController),
          overlayChildBuilder: (BuildContext context) => FocusScope(
            debugLabel: 'Popup',
            autofocus: true,
            child: Center(
              child: EnhancedCompositedTransformFollower(
                link: _layerLink, // link the follower widget to the target widget.
                showWhenUnlinked: false, // don't show the follower widget when unlinked.
                followerAnchor: widget.followerAnchor,
                targetAnchor: widget.targetAnchor,
                edgePadding: widget.edgeInsets,
                child: Builder(builder: (context) => widget.follower(context, portalController)),
              ),
            ),
          ),
        ),
      );
}

/// Follower builder that wraps the child widget.
typedef PopupFollowerBuilder = Widget Function(BuildContext context, Widget? child);

/// {@template popup_follower}
/// A widget that adds additional functionality to the child widget.
///
/// It listens for the escape key and dismisses the popup when pressed.
/// It also listens for the tap outside the child widget and dismisses the popup.
/// {@endtemplate}
class PopupFollower extends StatelessWidget {
  /// Creates a new instance of [PopupFollower].
  ///
  /// {@macro popup_follower}
  const PopupFollower({
    this.child,
    this.builder,
    this.onDismiss,
    this.tapRegionGroupId,
    super.key,
  }) : assert(child != null || builder != null);

  /// The child widget that is wrapped.
  final Widget? child;

  /// Optional builder that wraps the child widget.
  final PopupFollowerBuilder? builder;

  /// The callback that is called when the popup is dismissed.
  ///
  /// If this callback is not provided, the popup will not be dismissible.
  final VoidCallback? onDismiss;

  /// The group id of the [TapRegion].
  final Object? tapRegionGroupId;

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (builder != null) {
      child = builder!(context, this.child);
    } else {
      child = this.child;
    }

    return Actions(
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => onDismiss?.call(),
        ),
      },
      child: Shortcuts(
        debugLabel: 'PopupFollower',
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
        },
        child: Focus(
          autofocus: true,
          child: TapRegion(
            groupId: tapRegionGroupId,
            onTapOutside: (_) => onDismiss?.call(),
            child: child,
          ),
        ),
      ),
    );
  }
}
