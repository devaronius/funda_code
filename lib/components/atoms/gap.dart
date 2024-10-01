import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Gap extends LeafRenderObjectWidget {
  const Gap(this.size, {Key? key}) : super(key: key);

  final double size;

  @override
  RenderGap createRenderObject(BuildContext context) => RenderGap(size);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderGap renderObject) {
    renderObject.gap = size;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderGap extends RenderBox {
  RenderGap(this._gap) : super() {
    markNeedsLayout();
  }

  double _gap;
  double get gap => _gap;

  set gap(double value) {
    if (_gap != value) {
      _gap = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final parent = this.parent;
    Size newSize;
    if (parent is RenderFlex) {
      switch (parent.direction) {
        case Axis.vertical:
          newSize = Size(0, gap);
          break;
        case Axis.horizontal:
          newSize = Size(gap, 0);
          break;
      }
    } else {
      newSize = Size.square(gap);
    }
    size = constraints.constrain(newSize);
  }
}

class SliverGap extends LeafRenderObjectWidget {
  const SliverGap(this.gap, {Key? key}) : super(key: key);

  final double gap;

  @override
  RenderSliverGap createRenderObject(BuildContext context) =>
      RenderSliverGap(gap);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderSliverGap renderObject) {
    renderObject.gap = gap;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderSliverGap extends RenderSliver {
  RenderSliverGap(this._gap) : super() {
    markNeedsLayout();
  }

  double _gap;
  double get gap => _gap;

  set gap(double value) {
    if (_gap != value) {
      _gap = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final cacheExtent = calculateCacheOffset(constraints, from: 0, to: gap);
    final paintExtent = calculatePaintOffset(constraints, from: 0, to: gap);
    geometry = SliverGeometry(
      paintExtent: paintExtent,
      scrollExtent: gap,
      visible: false,
      cacheExtent: cacheExtent,
      maxPaintExtent: gap,
    );
  }
}
