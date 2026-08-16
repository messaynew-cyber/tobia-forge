import 'package:flutter/material.dart';
import '../theme.dart';

/// Staggered entrance — items reveal with physics ease + slight lift.
class StaggeredEntrance extends StatelessWidget {
  final Widget child;
  final int index;
  final double delayMs;
  const StaggeredEntrance({super.key, required this.child, this.index = 0, this.delayMs = 70});

  @override
  Widget build(BuildContext context) {
    final d = Duration(milliseconds: (index * delayMs).round());
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: Duration(milliseconds: 600) + d,
      curve: CurveTween(curve: const Cubic(0.16, 1, 0.3, 1)),
      builder: (_, v, child) => Opacity(
        opacity: 1 - v.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 24 * v.clamp(0.0, 1.0)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// FadeScaleIn — a clean pop for cards/surfaces on entry.
class FadeScaleIn extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double fromScale;
  const FadeScaleIn({super.key, required this.child, this.duration = const Duration(milliseconds: 500), this.fromScale = 0.95});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: CurveTween(curve: const Cubic(0.16, 1, 0.3, 1)),
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.scale(scale: fromScale + (1 - fromScale) * v, child: child),
      ),
      child: child,
    );
  }
}

/// Infinite gentle "breathing" glow for the hero accent (kinetic feel).
class BreathingGlow extends StatefulWidget {
  final Widget child; final Color color;
  const BreathingGlow({super.key, required this.child, required this.color});
  @override
  State<BreathingGlow> createState() => _BreathingGlowState();
}
class _BreathingGlowState extends State<BreathingGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200))..repeat(reverse: true);
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _c, builder: (_, child) {
      final t = 0.6 + 0.4 * _c.value;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: widget.color.withOpacity(0.10 * _c.value), blurRadius: 40, spreadRadius: 6),
          ],
        ),
        child: child,
      );
    }, child: widget.child);
  }
}

/// SlideReveal for section headers.
class SlideReveal extends StatelessWidget {
  final Widget child; final bool fromRight;
  const SlideReveal({super.key, required this.child, this.fromRight = false});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: Offset(fromRight ? 1 : -1, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 640),
      curve: CurveTween(curve: const Cubic(0.16, 1, 0.3, 1)),
      builder: (_, o, child) => FractionalTranslation(translation: Offset(o.dx * 0.06, 0), child: child),
      child: child,
    );
  }
}
