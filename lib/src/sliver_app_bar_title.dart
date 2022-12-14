import 'package:flutter/material.dart';
import 'package:sliver_app_bar_title/src/extensions.dart';

///A Title Widget for  pinned [SliverAppBar]
class SliverAppBarTitle extends StatefulWidget {
  const SliverAppBarTitle({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
    required this.targetWidgetKey,
  });

  ///child widget
  final Widget child;

  ///target widget [GlobalKey]
  final GlobalKey targetWidgetKey;

  ///Fade duration
  final Duration duration;

  ///Curve
  final Curve curve;

  @override
  State<SliverAppBarTitle> createState() => _SliverAppBarTitleState();
}

class _SliverAppBarTitleState extends State<SliverAppBarTitle>
    with SingleTickerProviderStateMixin {
  ScrollPosition? _scrollPosition;
  late bool showTitle;

  late final _controller =
      AnimationController(duration: widget.duration, vsync: this);

  late final _animation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    _removeListener();
    _scrollPosition?.dispose();
    super.dispose();
  }

  _addListener() {
    _scrollPosition = Scrollable.of(context)?.position;
    _scrollPosition?.addListener(_listener);
  }

  _removeListener() {
    _scrollPosition?.removeListener(_listener);
  }

  _listener() {
    final sliverAppBar = context.findAncestorWidgetOfExactType<SliverAppBar>();

    if (_scrollPosition != null && sliverAppBar != null) {
      final double bottomHeight =
          sliverAppBar.bottom?.preferredSize.height ?? 0.0;
      final double topPadding =
          sliverAppBar.primary ? MediaQuery.of(context).padding.top : 0.0;
      final double collapsedHeight = (sliverAppBar.pinned &&
              sliverAppBar.floating &&
              sliverAppBar.bottom != null)
          ? (sliverAppBar.collapsedHeight ?? 0.0) + bottomHeight + topPadding
          : (sliverAppBar.collapsedHeight ?? sliverAppBar.toolbarHeight) +
              bottomHeight +
              topPadding;
      final bottomPoint = widget.targetWidgetKey.globalPaintBounds?.bottom;

      if (!_controller.isAnimating) {
        if (bottomPoint != null && (bottomPoint - collapsedHeight) < 0) {
          _controller.forward();
          return;
        }
      }

      if (_controller.isCompleted) {
        if (bottomPoint != null && (bottomPoint - collapsedHeight) > 0) {
          _controller.reverse();
          return;
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    _removeListener();
    _addListener();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
