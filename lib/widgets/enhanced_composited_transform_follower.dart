import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:popup_playground/widgets/enhanced_composited_transform_target.dart';

/// A widget that follows a [CompositedTransformTarget].
/// 
/// The only difference between this widget and [CompositedTransformFollower] is
/// that this widget prevents the follower from overflowing the screen.
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// applies a transformation that brings [targetAnchor] of the linked
/// [CompositedTransformTarget] and [followerAnchor] of this widget together.
/// The two anchor points will have the same global coordinates, unless [edgePadding]
/// is not [Offset.zero], in which case [followerAnchor] will be offset by
/// [edgePadding] in the linked [CompositedTransformTarget]'s coordinate space.
///
/// The [LayerLink] object used as the [link] must be the same object as that
/// provided to the matching [CompositedTransformTarget].
///
/// The [CompositedTransformTarget] must come earlier in the paint order than
/// this [EnhancedCompositedTransformFollower].
///
/// Hit testing on descendants of this widget will only work if the target
/// position is within the box that this widget's parent considers to be
/// hittable. If the parent covers the screen, this is trivially achievable, so
/// this widget is usually used as the root of an [OverlayEntry] in an app-wide
/// [Overlay] (e.g. as created by the [MaterialApp] widget's [Navigator]).
///
/// See also:
///
///  * [CompositedTransformTarget], the widget that this widget can target.
///  * [EnhancedFollowerLayer], the layer that implements this widget's logic.
///  * [Transform], which applies an arbitrary transform to a child.
class EnhancedCompositedTransformFollower extends SingleChildRenderObjectWidget {
  /// Creates a composited transform target widget.
  ///
  /// If the [link] property was also provided to a [CompositedTransformTarget],
  /// that widget must come earlier in the paint order.
  ///
  /// The [showWhenUnlinked] and [edgePadding] properties must also not be null.
  const EnhancedCompositedTransformFollower({
    super.key,
    required this.link,
    this.showWhenUnlinked = true,
    this.edgePadding = EdgeInsets.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
    super.child,
  });

  /// The link object that connects this [EnhancedCompositedTransformFollower] with a
  /// [CompositedTransformTarget].
  final EnhancedLayerLink link;

  /// Whether to show the widget's contents when there is no corresponding
  /// [CompositedTransformTarget] with the same [link].
  ///
  /// When the widget is linked, the child is positioned such that it has the
  /// same global position as the linked [CompositedTransformTarget].
  ///
  /// When the widget is not linked, then: if [showWhenUnlinked] is true, the
  /// child is visible and not repositioned; if it is false, then child is
  /// hidden.
  final bool showWhenUnlinked;

  /// The anchor point on the linked [CompositedTransformTarget] that
  /// [followerAnchor] will line up with.
  ///
  /// {@template flutter.widgets.CompositedTransformFollower.targetAnchor}
  /// For example, when [targetAnchor] and [followerAnchor] are both
  /// [Alignment.topLeft], this widget will be top left aligned with the linked
  /// [CompositedTransformTarget]. When [targetAnchor] is
  /// [Alignment.bottomLeft] and [followerAnchor] is [Alignment.topLeft], this
  /// widget will be left aligned with the linked [CompositedTransformTarget],
  /// and its top edge will line up with the [CompositedTransformTarget]'s
  /// bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment targetAnchor;

  /// The anchor point on this widget that will line up with [targetAnchor] on
  /// the linked [CompositedTransformTarget].
  ///
  /// {@macro flutter.widgets.CompositedTransformFollower.targetAnchor}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment followerAnchor;

  /// Minimum padding from the edge of the screen.
  final EdgeInsets edgePadding;

  @override
  EnhancedRenderFollowerLayer createRenderObject(BuildContext context) {
    return EnhancedRenderFollowerLayer(
      link: link,
      showWhenUnlinked: showWhenUnlinked,
      edgePadding: edgePadding,
      leaderAnchor: targetAnchor,
      followerAnchor: followerAnchor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, EnhancedRenderFollowerLayer renderObject) {
    renderObject
      ..link = link
      ..showWhenUnlinked = showWhenUnlinked
      ..leaderAnchor = targetAnchor
      ..followerAnchor = followerAnchor
      ..edgePadding = edgePadding;
  }
}

/// Transform the child so that its origin is [offset] from the origin of the
/// [RenderLeaderLayer] with the same [LayerLink].
///
/// The [RenderLeaderLayer] in question must be earlier in the paint order.
///
/// Hit testing on descendants of this render object will only work if the
/// target position is within the box that this render object's parent considers
/// to be hittable.
///
/// See also:
///
///  * [CompositedTransformFollower], the corresponding widget.
///  * [FollowerLayer], the layer that this render object creates.
class EnhancedRenderFollowerLayer extends RenderProxyBox {
  /// Creates a render object that uses a [EnhancedFollowerLayer].
  EnhancedRenderFollowerLayer({
    required EnhancedLayerLink link,
    bool showWhenUnlinked = true,
    EdgeInsets edgePadding = EdgeInsets.zero,
    Alignment leaderAnchor = Alignment.topLeft,
    Alignment followerAnchor = Alignment.topLeft,
    RenderBox? child,
  })  : _link = link,
        _showWhenUnlinked = showWhenUnlinked,
        _edgePadding = edgePadding,
        _leaderAnchor = leaderAnchor,
        _followerAnchor = followerAnchor,
        super(child);

  /// The link object that connects this [EnhancedRenderFollowerLayer] with a
  /// [RenderLeaderLayer] earlier in the paint order.
  EnhancedLayerLink get link => _link;
  EnhancedLayerLink _link;
  set link(EnhancedLayerLink value) {
    if (_link == value) {
      return;
    }
    _link = value;
    markNeedsPaint();
  }

  /// Minimum padding from the edge of the screen.
  EdgeInsets get edgePadding => _edgePadding;
  EdgeInsets _edgePadding;
  set edgePadding(EdgeInsets value) {
    if (_edgePadding == value) {
      return;
    }
    _edgePadding = value;
    markNeedsPaint();
  }

  /// Whether to show the render object's contents when there is no
  /// corresponding [RenderLeaderLayer] with the same [link].
  ///
  /// When the render object is linked, the child is positioned such that it has
  /// the same global position as the linked [RenderLeaderLayer].
  ///
  /// When the render object is not linked, then: if [showWhenUnlinked] is true,
  /// the child is visible and not repositioned; if it is false, then child is
  /// hidden, and its hit testing is also disabled.
  bool get showWhenUnlinked => _showWhenUnlinked;
  bool _showWhenUnlinked;
  set showWhenUnlinked(bool value) {
    if (_showWhenUnlinked == value) {
      return;
    }
    _showWhenUnlinked = value;
    markNeedsPaint();
  }

  /// The anchor point on the linked [RenderLeaderLayer] that [followerAnchor]
  /// will line up with.
  ///
  /// {@template flutter.rendering.RenderFollowerLayer.leaderAnchor}
  /// For example, when [leaderAnchor] and [followerAnchor] are both
  /// [Alignment.topLeft], this [EnhancedRenderFollowerLayer] will be top left aligned
  /// with the linked [RenderLeaderLayer]. When [leaderAnchor] is
  /// [Alignment.bottomLeft] and [followerAnchor] is [Alignment.topLeft], this
  /// [EnhancedRenderFollowerLayer] will be left aligned with the linked
  /// [RenderLeaderLayer], and its top edge will line up with the
  /// [RenderLeaderLayer]'s bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get leaderAnchor => _leaderAnchor;
  Alignment _leaderAnchor;
  set leaderAnchor(Alignment value) {
    if (_leaderAnchor == value) {
      return;
    }
    _leaderAnchor = value;
    markNeedsPaint();
  }

  /// The anchor point on this [EnhancedRenderFollowerLayer] that will line up with
  /// [followerAnchor] on the linked [RenderLeaderLayer].
  ///
  /// {@macro flutter.rendering.RenderFollowerLayer.leaderAnchor}
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get followerAnchor => _followerAnchor;
  Alignment _followerAnchor;
  set followerAnchor(Alignment value) {
    if (_followerAnchor == value) {
      return;
    }
    _followerAnchor = value;
    markNeedsPaint();
  }

  @override
  void detach() {
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  /// The layer we created when we were last painted.
  @override
  FollowerLayer? get layer => super.layer as FollowerLayer?;

  /// Return the transform that was used in the last composition phase, if any.
  ///
  /// If the [EnhancedFollowerLayer] has not yet been created, was never composited, or
  /// was unable to determine the transform (see
  /// [EnhancedFollowerLayer.getLastTransform]), this returns the identity matrix (see
  /// [Matrix4.identity].
  Matrix4 getCurrentTransform() {
    return layer?.getLastTransform() ?? Matrix4.identity();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Disables the hit testing if this render object is hidden.
    if (link.leader == null && !showWhenUnlinked) {
      return false;
    }
    // RenderFollowerLayer objects don't check if they are
    // themselves hit, because it's confusing to think about
    // how the untransformed size and the child's transformed
    // position interact.
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintTransform(
      transform: getCurrentTransform(),
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void performLayout() {
    final constraints = this.constraints.deflate(edgePadding);

    size = (child?..layout(constraints, parentUsesSize: true))?.size ??
        computeSizeForNoChild(constraints);
    return;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(
      link.leaderSize != null || link.leader == null || leaderAnchor == Alignment.topLeft,
      '$link: layer is linked to ${link.leader} but a valid leaderSize is not set. '
      'leaderSize is required when leaderAnchor is not Alignment.topLeft '
      '(current value is $leaderAnchor).',
    );
    // If the leader is not linked, and we're not supposed to show anything
    final unlinkedOffset = offset;

    final leaderGlobalPosition = link.leaderRenderObject!.localToGlobal(Offset.zero);
    final leaderSize = link.leaderSize!;

    final relativeOffset = leaderAnchor.alongSize(leaderSize) - followerAnchor.alongSize(size);
    final followerGlobalPosition = leaderGlobalPosition + relativeOffset;

    final linkedOffset = _adjustForOverflow(
          followerRect: Rect.fromLTWH(
            followerGlobalPosition.dx,
            followerGlobalPosition.dy,
            size.width,
            size.height,
          ),
          targetRect: Rect.fromLTWH(
            leaderGlobalPosition.dx,
            leaderGlobalPosition.dy,
            leaderSize.width,
            leaderSize.height,
          ),
          screenSize: constraints.biggest,
          edgePadding: edgePadding,
        ) -
        leaderGlobalPosition;

    if (layer == null) {
      layer = FollowerLayer(
        link: link,
        showWhenUnlinked: showWhenUnlinked,
        linkedOffset: linkedOffset,
        unlinkedOffset: unlinkedOffset,
      );
    } else {
      layer
        ?..link = link
        ..showWhenUnlinked = showWhenUnlinked
        ..linkedOffset = linkedOffset
        ..unlinkedOffset = unlinkedOffset;
    }
    context.pushLayer(
      layer!,
      super.paint,
      Offset.zero,
      childPaintBounds: const Rect.fromLTRB(
        // We don't know where we'll end up, so we have no idea what our cull rect should be.
        double.negativeInfinity,
        double.negativeInfinity,
        double.infinity,
        double.infinity,
      ),
    );
    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }

  Offset _adjustForOverflow({
  required Rect followerRect,
  required Rect targetRect,
  required Size screenSize,
  required EdgeInsets edgePadding,
}) {
  double dx = followerRect.left;
  double dy = followerRect.top;

  // Effective screen area considering edge padding
  final double leftBoundary = edgePadding.left;
  final double topBoundary = edgePadding.top;
  final double rightBoundary = screenSize.width - edgePadding.right;
  final double bottomBoundary = screenSize.height - edgePadding.bottom;

  // Check for horizontal overflow
  if (dx + followerRect.width > rightBoundary) {
    // Not enough space on the right, try left side
    if (targetRect.left - followerRect.width >= leftBoundary) {
      dx = targetRect.left - followerRect.width;
    } else {
      dx = rightBoundary - followerRect.width;
    }
  } else if (dx < leftBoundary) {
    // Not enough space on the left, try right side
    if (targetRect.right + followerRect.width <= rightBoundary) {
      dx = targetRect.right;
    } else {
      dx = leftBoundary;
    }
  }

  // Check for vertical overflow
  if (dy + followerRect.height > bottomBoundary) {
    // Not enough space at the bottom, try top side
    if (targetRect.top - followerRect.height >= topBoundary) {
      dy = targetRect.top - followerRect.height;
    } else {
      dy = bottomBoundary - followerRect.height;
    }
  } else if (dy < topBoundary) {
    // Not enough space at the top, try bottom side
    if (targetRect.bottom + followerRect.height <= bottomBoundary) {
      dy = targetRect.bottom;
    } else {
      dy = topBoundary;
    }
  }

  return Offset(dx, dy);
}

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(getCurrentTransform());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LayerLink>('link', link));
    properties.add(DiagnosticsProperty<bool>('showWhenUnlinked', showWhenUnlinked));
    properties.add(TransformProperty('current transform matrix', getCurrentTransform()));
  }
}
