import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/forge_surface.dart';
import '../widgets/animated.dart';

/// SETTINGS page — app config, about, and profile.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                Text('CONFIG', style: ForgeType.kicker(color: ForgeColors.gold)),
                const SizedBox(height: 6),
                Text('Settings', style: ForgeType.hero(34)),
                const SizedBox(height: 6),
                Text('Tune the operator. This is the quiet part of the forge.',
                  style: ForgeType.body(color: ForgeColors.muted, size: 13)),
              ]))),
            SliverPadding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 40), sliver: SliverList.list(children: [
              _group('APPEARANCE', [
                _toggle('Dark Mode', Icons.dark_mode_rounded, true),
                _toggle('True OLED Black', Icons.circle_rounded, true),
                _toggle('Reduced Motion', Icons.motion_photos_off_rounded, false),
              ]),
              const SizedBox(height: 22),
              _group('BEHAVIOR', [
                _toggle('Thermal Discipline', Icons.thermostat_rounded, true),
                _toggle('Auto-Refresh Stats', Icons.refresh_rounded, true),
                _toggle('Sentinel Alerts', Icons.visibility_rounded, true),
              ]),
              const SizedBox(height: 22),
              _group('ABOUT', [
                _aboutRow('Operator', 'TOBIA'),
                _aboutRow('Version', '3.0.0'),
                _aboutRow('Built', 'On the Vessel'),
                _aboutRow('Motto', 'ADWA OUT'),
              ]),
              const SizedBox(height: 26),
              Center(child: Text('T O B I A', style: ForgeType.kicker(color: ForgeColors.faint))),
              const SizedBox(height: 6),
              Center(child: Text('PHONEMAKER · ETHIOPIA · 2026', style: ForgeType.kicker(size: 9, color: ForgeColors.faint))),
            ])),
          ],
        ),
      ),
    );
  }

  Widget _group(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SlideReveal(child: Text(title, style: ForgeType.kicker(color: ForgeColors.gold))),
      const SizedBox(height: 10),
      ForgeSurface(padding: const EdgeInsets.all(6), radius: 24, child: Column(children: [
        for (var i=0;i<children.length;i++) ...[
          if (i>0) Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: ForgeColors.glassBorder),
          children[i],
        ],
      ])),
    ]);
  }

  Widget _toggle(String label, IconData icon, bool value) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(children: [
        Icon(icon, color: ForgeColors.muted, size: 19),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: ForgeType.body(color: ForgeColors.text))),
        Switch(value: value, onChanged: (_) {}, activeColor: ForgeColors.emerald, activeTrackColor: ForgeColors.emerald.withOpacity(0.3)),
      ]));
  }

  Widget _aboutRow(String k, String v) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Expanded(child: Text(k, style: ForgeType.kicker(color: ForgeColors.muted, size: 10))),
        Text(v, style: ForgeType.mono(13, color: ForgeColors.gold)),
      ]));
  }
}
