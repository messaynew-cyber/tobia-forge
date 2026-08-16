import 'package:flutter/material.dart';
import '../theme.dart';
import '../scenes.dart';
import '../widgets/forge_surface.dart';
import '../widgets/animated.dart';
import 'scene_screen.dart';

/// SCENES page — all five facets as a dedicated gallery.
class ScenesListScreen extends StatelessWidget {
  const ScenesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.bg0,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), sliver: SliverToBoxAdapter(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('THE FORGE', style: ForgeType.kicker(color: ForgeColors.gold)),
                const SizedBox(height: 6),
                Text('Five Facets', style: ForgeType.hero(34)),
                const SizedBox(height: 6),
                Text('The story of a phone that builds. Tap any facet to dive in.',
                  style: ForgeType.body(color: ForgeColors.muted, size: 13)),
              ]))),
            SliverPadding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 40), sliver: SliverList.list(
              children: kScenes.map((s) {
                final i = s.index - 1;
                return Padding(padding: EdgeInsets.only(bottom: 16), child: StaggeredEntrance(index: i, delayMs: 90,
                  child: ForgeSurface(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SceneScreen(scene: s))),
                    glow: s.glow, glowStrength: 0.12, radius: 26, padding: const EdgeInsets.all(14),
                    child: Row(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(14),
                        child: SizedBox(width: 92, height: 92, child: Image.asset(s.imageAsset, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: ForgeColors.bg2, child: Icon(s.icon, color: s.glow, size: 34))))),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(s.kicker, style: ForgeType.kicker(size: 9, color: s.glow)),
                        const SizedBox(height: 6),
                        Text(s.title, style: ForgeType.hero(18), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 6),
                        Row(children: [
                          Text('EXPLORE', style: ForgeType.mono(10, color: s.glow)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, color: s.glow, size: 14),
                        ]),
                      ])),
                    ]))));
              }).toList())));
         ],
        ),
      ),
    );
  }
}
