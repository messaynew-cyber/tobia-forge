import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../scenes.dart';
import '../widgets/forge_surface.dart';

/// TOBIA — THE FORGE 2.0
/// 2026 canon: bento hierarchy · kinetic type · glass 2.0 depth · spring motion.
class ForgeScreen extends StatefulWidget {
  const ForgeScreen({super.key});
  @override
  State<ForgeScreen> createState() => _ForgeScreenState();
}

class _ForgeScreenState extends State<ForgeScreen> {
  int _battery = 86; double _temp = 38.0; String _health = 'GOOD'; String _charge = 'UNPLUGGED';
  int _mem = 159; int _tools = 112;
  static const _channel = MethodChannel('tobia_forge/hardware');

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final m = await _channel.invokeMapMethod('deviceStats');
      if (m != null && mounted) setState(() {
        _battery = (m['battery'] as num?)?.toInt() ?? _battery;
        _temp = (m['temp'] as num?)?.toDouble() ?? _temp;
        _health = (m['health'] as String?) ?? _health;
        _charge = (m['charge'] as String?) ?? _charge;
      });
    } catch (_) {}
  }

  String get _zone {
    if (_temp > 43) return 'EMERGENCY';
    if (_temp > 40) return 'SURVIVAL';
    if (_temp > 35) return 'THROTTLED';
    return 'DISCIPLINED';
  }
  Color get _zoneColor {
    if (_temp > 40) return ForgeColors.crimson;
    if (_temp > 35) return ForgeColors.gold;
    return ForgeColors.emerald;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.bg0,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _topBar(),
            SliverPadding(padding: const EdgeInsets.fromLTRB(20, 6, 20, 40), sliver: SliverList.list(children: [
              _hero(),
              const SizedBox(height: 30),
              _sectionHead('OPERATOR STATUS', 'LIVE · 2026'),
              const SizedBox(height: 16),
              _bentoGrid(),
              const SizedBox(height: 34),
              _sectionHead('THE FORGE', 'THE FIVE FACETS'),
              const SizedBox(height: 8),
              _scenes(),
              const SizedBox(height: 30),
              _systemHealth(),
              const SizedBox(height: 40),
              _footer(),
            ])),
          ],
        ),
      ),
    );
  }

  Widget _topBar() => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('TOBIA · FORGE 2.0', style: ForgeType.kicker(color: ForgeColors.text, size: 12)),
        Row(children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(
            shape: BoxShape.circle, color: ForgeColors.emerald,
            boxShadow: [BoxShadow(color: ForgeColors.emerald, blurRadius: 10, spreadRadius: 1)],
          )),
          const SizedBox(width: 8),
          Text('SIGNAL', style: ForgeType.mono(10, color: ForgeColors.textSoft)),
        ]),
      ]),
    ),
  );

  Widget _hero() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      Text('THE FORGE', style: ForgeType.kicker(color: ForgeColors.gold)),
      const SizedBox(height: 6),
      Text.rich(TextSpan(children: [
        TextSpan(text: 'One phone.\n', style: ForgeType.hero(44)),
        TextSpan(text: 'Whole ', style: ForgeType.hero(44, color: ForgeColors.emerald)),
        TextSpan(text: 'universe.', style: ForgeType.hero(44)),
      ])),
      const SizedBox(height: 12),
      Text('digital sentinel · phonemaker · ethiopia · 2026',
          style: ForgeType.mono(11, color: ForgeColors.muted)),
    ]);
  }

  Widget _sectionHead(String title, String sub) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(sub, style: ForgeType.kicker(color: ForgeColors.gold)),
    const SizedBox(height: 6),
    Text(title, style: ForgeType.hero(26)),
  ]);

  // ================= BENTO GRID =================
  Widget _bentoGrid() {
    final batteryFrac = _battery.clamp(0, 100) / 100;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 3, child: ForgeSurface(
          glow: ForgeColors.emerald, glowStrength: 0.22, raised: true,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('BATTERY', style: ForgeType.kicker(color: ForgeColors.emerald)),
            const SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              Text('$_battery', style: ForgeType.hero(54)),
              const SizedBox(width: 4),
              Text('%', style: ForgeType.mono(18, color: ForgeColors.emerald)),
            ]),
            const SizedBox(height: 10),
            ClipRRect(borderRadius: BorderRadius.circular(6), child: Container(height: 7, color: ForgeColors.bg3,
              child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: batteryFrac,
                child: Container(decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [ForgeColors.emeraldDeep, ForgeColors.emerald]),
                  borderRadius: BorderRadius.circular(6)))),
            )),
            const SizedBox(height: 10),
            Text('$_temp°C · $_health', style: ForgeType.mono(11, color: ForgeColors.textSoft)),
            const SizedBox(height: 2),
            Text(_charge, style: ForgeType.mono(10, color: ForgeColors.muted)),
          ]),
        )),
        const SizedBox(width: 14),
        Expanded(flex: 2, child: ForgeSurface(
          glow: ForgeColors.gold, glowStrength: 0.18, padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MEMORY', style: ForgeType.kicker(color: ForgeColors.gold)),
            const SizedBox(height: 12),
            Text('$_mem', style: ForgeType.hero(34)),
            const SizedBox(height: 4),
            Text('INDEXED', style: ForgeType.mono(10, color: ForgeColors.muted)),
          ]),
        )),
      ]),
      const SizedBox(height: 14),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 2, child: ForgeSurface(
          glow: _zoneColor, glowStrength: 0.16, padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('THERMAL', style: ForgeType.kicker(color: _zoneColor)),
            const SizedBox(height: 12),
            Text(_zone, style: ForgeType.hero(26, color: _zoneColor)),
            const SizedBox(height: 4),
            Text('$_temp°C ZONE', style: ForgeType.mono(10, color: ForgeColors.muted)),
          ]),
        )),
        const SizedBox(width: 14),
        Expanded(flex: 2, child: ForgeSurface(
          glow: ForgeColors.sky, glowStrength: 0.14, padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('TOOLS', style: ForgeType.kicker(color: ForgeColors.sky)),
            const SizedBox(height: 12),
            Text('$_tools', style: ForgeType.hero(34)),
            const SizedBox(height: 4),
            Text('LOADED', style: ForgeType.mono(10, color: ForgeColors.muted)),
          ]),
        )),
      ]),
    ]);
  }

  // ================= SCENES =================
  Widget _scenes() {
    return Column(children: kScenes.map((s) {
      return Padding(
        padding: EdgeInsets.only(top: s.index == 1 ? 0 : 12),
        child: ForgeSurface(
          glow: s.glow, glowStrength: 0.13,
          onTap: () { /* immersive expand reserved */ },
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 3, height: 26, decoration: BoxDecoration(
                color: s.glow, borderRadius: BorderRadius.circular(2),
              )),
              const SizedBox(width: 12),
              Text(s.kicker, style: ForgeType.kicker(size: 10, color: s.glow)),
            ]),
            const SizedBox(height: 12),
            ...s.titleLines.asMap().entries.map((e) => Padding(
              padding: EdgeInsets.only(top: e.key == 0 ? 0 : 2),
              child: Text(e.value, style: e.key == s.titleLines.length - 1
                ? ForgeType.hero(28, color: s.glow) : ForgeType.hero(28)),
            )),
            const SizedBox(height: 10),
            Text(s.body, style: ForgeType.body(color: ForgeColors.textSoft, size: 13)),
          ]),
        ),
      );
    }).toList());
  }

  // ================= SYSTEM HEALTH =================
  Widget _systemHealth() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHead('SYSTEM', 'HEALTH CHECK'),
      const SizedBox(height: 12),
      ForgeSurface(padding: const EdgeInsets.all(18), child: Wrap(spacing: 10, runSpacing: 10, children: [
        _pill('Oracle VPS', 'ONLINE', ForgeColors.emerald),
        _pill('Gateway 18790', 'UP', ForgeColors.gold),
        _pill('Worker Daemon', 'RUN', ForgeColors.sky),
        _pill('Error Log', 'CLEAN', ForgeColors.emerald),
      ])),
    ]);
  }

  Widget _pill(String name, String status, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(
      color: color.withOpacity(0.09),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.24)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: 6)])),
      const SizedBox(width: 8),
      Text('$name · $status', style: ForgeType.mono(11, color: ForgeColors.textSoft)),
    ]),
  );

  // ================= FOOTER =================
  Widget _footer() {
    return Column(children: [
      Text.rich(TextSpan(children: [
        TextSpan(text: 'T  O  B  I  A', style: ForgeType.kicker(color: ForgeColors.text)),
      ])),
      const SizedBox(height: 8),
      Text('THE PHONEMAKER · BUILT ON THE VESSEL', style: ForgeType.kicker(size: 9, color: ForgeColors.faint)),
      const SizedBox(height: 6),
      Text('ADWA OUT', style: ForgeType.mono(11, spacing: 2.6, color: ForgeColors.muted)),
    ]);
  }
}
