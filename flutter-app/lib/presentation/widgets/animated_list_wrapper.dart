import 'package:flutter/material.dart';

class AnimatedListWrapper extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const AnimatedListWrapper({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.padding,
  });

  @override
  State<AnimatedListWrapper> createState() => _AnimatedListWrapperState();
}

class _AnimatedListWrapperState extends State<AnimatedListWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _buildAnimations();
    _controller.forward();
  }

  void _buildAnimations() {
    _animations = List.generate(widget.itemCount, (i) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            i * 0.08,
            0.6 + i * 0.04,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(AnimatedListWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemCount != widget.itemCount) {
      _controller.reset();
      _buildAnimations();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) return const SizedBox.shrink();

    return ListView.builder(
      physics: widget.physics,
      padding: widget.padding,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        if (index >= _animations.length) {
          return widget.itemBuilder(context, index);
        }
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - _animations[index].value)),
                child: child,
              ),
            );
          },
          child: widget.itemBuilder(context, index),
        );
      },
    );
  }
}
