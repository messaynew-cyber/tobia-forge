import 'package:flutter/material.dart';
import '../theme.dart';
import '../scenes.dart';
import '../widgets/animated.dart';

/// Immersive per-scene detail — FLUX art hero + longform story.
class SceneScreen extends StatelessWidget {
  final ForgeScene scene;
  const SceneScreen({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.bg0,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: ForgeColors.bg0,
            leading: Padding(padding: const EdgeInsets.all(6),
              child: IconButton(onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, color: ForgeColors.text),
                style: IconButton.styleFrom(backgroundColor: ForgeColors.bg2.withOpacity(0.7)))),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Image.asset(scene.imageAsset, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
                DecoratedBox(decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, ForgeColors.bg0.withOpacity(0.4), ForgeColors.bg0]))),
              ]),
            ),
          ),
          SliverPadding(padding: const EdgeInsets.fromLTRB(22, 14, 22, 44), sliver: SliverList.list(children: [
            SlideReveal(child: Text(scene.kicker, style: ForgeType.kicker(color: scene.glow))),
            const SizedBox(height: 10),
            for (var i=0;i<scene.titleLines.length;i++)
              FadeScaleIn(duration: Duration(milliseconds: 420 + i*120), fromScale: 0.96,
                child: Padding(padding: EdgeInsets.only(top: i==0?2:4),
                  child: Text(scene.titleLines[i], style: i==scene.titleLines.length-1
                    ? ForgeType.hero(36, color: scene.glow) : ForgeType.hero(36)))),
            const SizedBox(height: 16),
            SlideReveal(child: Text(scene.longStory, style: ForgeType.body(size: 15))),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scene.glow.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scene.glow.withOpacity(0.22)),
              ),
              child: Row(children: [
                Icon(scene.icon, color: scene.glow, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(scene.meta, style: ForgeType.mono(11, color: scene.glow))),
              ]),
            ),
            const SizedBox(height: 24),
            Text('THE FORGE · ${scene.index.toString().padLeft(2,'0')}/05', style: ForgeType.kicker(size: 10, color: ForgeColors.faint)),
          ])),
        ],
      ),
    );
  }
}
