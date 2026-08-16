import 'package:flutter/material.dart';
import '../theme.dart';

/// OLED glassmorphism card with gold hairline + soft radial glow.
class ForgeCard extends StatelessWidget {
  final String? kicker;
  final String? value;
  final String? unit;
  final String? caption;
  final Color? valueColor;
  final Widget? child;
  final double progress; // 0..1 optional bar
  final Color? progressColor;
  final VoidCallback? onTap;
  final Duration stagger;

  const ForgeCard({
    super.key,
    this.kicker,
    this.value,
    this.unit,
    this.caption,
    this.valueColor,
    this.child,
    this.progress = -1,
    this.progressColor,
    this.onTap,
    this.stagger = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final c = valueColor ?? ForgeColors.text;
    final pc = progressColor ?? ForgeColors.gold;

    Widget body;
    if (child != null) {
      body = child!;
    } else {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kicker != null)
            Text(kicker!, style: ForgeType.label()),
          if (value != null) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 600),
                  curve: ForgeCurves.easeOut,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: c,
                    height: 1.1,
                  ),
                  child: Text(value!),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 6),
                  Text(unit!, style: ForgeType.mono(12, color: ForgeColors.muted)),
                ],
              ],
            ),
          ],
          if (caption != null) ...[
            const SizedBox(height: 6),
            Text(caption!, style: ForgeType.mono(10, color: ForgeColors.muted)),
          ],
          if (progress >= 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 5,
                color: Colors.white.withOpacity(0.07),
                child: AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 800),
                  curve: ForgeCurves.easeOut,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ForgeColors.goldDim, pc],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      curve: ForgeCurves.easeOut,
      opacity: 1,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 700),
        curve: ForgeCurves.easeOut,
        offset: Offset.zero,
        child: Material(
          color: ForgeColors.panel.withOpacity(0.55),
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: ForgeColors.hairline),
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  radius: 1.4,
                  colors: [
                    ForgeColors.gold.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6],
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
