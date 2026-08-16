import 'package:flutter/material.dart';
import '../theme.dart';

/// Glassmorphism 2.0 — transparency WITH depth.
/// Layered: whisper-white surface + hairline border + top-edge specular highlight
/// + radial inner glow + soft outer shadow. Not a flat frosted panel.
class ForgeSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? glow;
  final double glowStrength;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool raised;

  const ForgeSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
    this.radius = 28,
    this.glow,
    this.glowStrength = 0.14,
    this.borderRadius,
    this.onTap,
    this.raised = false,
  });

  BorderRadius get _br => borderRadius ?? BorderRadius.circular(radius);

  @override
  Widget build(BuildContext context) {
    final box = Container(
      // ===== depth base =====
      decoration: BoxDecoration(
        borderRadius: _br,
        // soft outer shadow lifts the tile off the bg (depth)
        boxShadow: raised
            ? [BoxShadow(color: Colors.black.withOpacity(0.55), blurRadius: 28, offset: const Offset(0, 16))]
            : null,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ForgeColors.glass,
            ForgeColors.bg1.withOpacity(0.55),
            ForgeColors.bg2.withOpacity(0.35),
          ],
        ),
        border: Border.all(color: ForgeColors.glassBorder, width: 1),
      ),
      child: Stack(
        children: [
          // ===== inner radial glow (brand moment) =====
          Positioned(
            top: -70, right: -70,
            child: Container(
              width: 180, height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [ (glow ?? ForgeColors.gold).withOpacity(glowStrength), Colors.transparent ],
                ),
              ),
            ),
          ),
          // ===== top-edge specular highlight (the glass 2.0 tell) =====
          Positioned(
            top: 0, left: 12, right: 12,
            child: IgnorePointer(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      ForgeColors.glassHighlight,
                      Colors.white.withOpacity(0.32),
                      ForgeColors.glassHighlight,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );

    return _springTap(child: box, onTap: onTap, borderRadius: _br);
  }
}

/// Micro-interaction system — every tap gets a physics spring response.
class _springTap extends StatefulWidget {
  final Widget child; final VoidCallback? onTap; final BorderRadius borderRadius;
  const _springTap({required this.child, this.onTap, required this.borderRadius});
  @override
  State<_springTap> createState() => _springTapState();
}
class _springTapState extends State<_springTap> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  Animation<double> get _scale => _c.drive(Tween(begin: 1.0, end: 0.955).chain(CurveTween(curve: const Interval(0, 0.5, curve: Curves.easeOut))));
  bool _down = false;

  @override
  void dispose() { _c.dispose(); super.dispose(); }
  void _onDown() { _down = true; _c.forward(); }
  void _onUp() { _down = false; _c.reverse(); }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _onDown(),
      onPointerUp: (_) => _onUp(),
      onPointerCancel: (_) => _onUp(),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Small press-scale utility for icon chips (compact springs).
class ForgeIconChip extends StatelessWidget {
  final IconData icon; final Color color; final String? label;
  final VoidCallback? onTap;
  const ForgeIconChip({super.key, required this.icon, required this.color, this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: EdgeInsets.symmetric(horizontal: label!=null?14:12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.24)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: color),
        if (label != null) ...[const SizedBox(width: 8), Text(label!, style: ForgeType.mono(11, color: color, spacing: 1.2))],
      ]),
    );
    return GestureDetector(onTap: onTap, child: chip);
  }
}
