import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../scenes.dart';
import '../widgets/forge_card.dart';

/// TOBIA — THE FORGE. Native OLED-black dashboard.
class ForgeScreen extends StatefulWidget {
  const ForgeScreen({super.key});
  @override
  State<ForgeScreen> createState() => _ForgeScreenState();
}

class _ForgeScreenState extends State<ForgeScreen>
    with SingleTickerProviderStateMixin {
  // Live device stats (populated via platform channel; graceful fallback).
  int _battery = 86;
  double _temp = 38.0;
  String _health = 'GOOD';
  String _chargeState = 'UNPLUGGED';
  int _memoryCount = 159;
  int _toolCount = 112;
  bool _loaded = false;

  static const _channel = MethodChannel('tobia_forge/hardware');
  final List<ForgeScene> _scenes = kScenes;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final map = await _channel.invokeMapMethod('deviceStats');
      if (map != null && mounted) {
        setState(() {
          _battery = (map['battery'] as num?)?.toInt() ?? _battery;
          _temp = (map['temp'] as num?)?.toDouble() ?? _temp;
          _health = (map['health'] as String?) ?? _health;
          _chargeState = (map['charge'] as String?) ?? _chargeState;
          _loaded = true;
        });
      }
    } catch (_) {
      // Platform channel unavailable — keep graceful fallbacks.
    }
  }

  String get _thermalZone {
    if (_temp > 43) return 'EMERGENCY';
    if (_temp > 40) return 'SURVIVAL';
    if (_temp > 35) return 'THROTTLED';
    return 'DISCIPLINED';
  }

  Color get _thermalColor {
    if (_temp > 43) return ForgeColors.red;
    if (_temp > 40) return ForgeColors.red;
    if (_temp > 35) return ForgeColors.gold;
    return ForgeColors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.oled,
      body: Stack(
        children: [
          _ambientGlow(),
          SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 60),
              children: [
                _topBar(),
                const SizedBox(height: 30),
                _identityBanner(),
                const SizedBox(height: 30),
                _sectionHead('Operator Status', 'LIVE · 2026'),
                const SizedBox(height: 16),
                _statGrid(),
                const SizedBox(height: 34),
                _sectionHead('The Forge', 'A PHONE, FORGING A PHONE'),
                const SizedBox(height: 16),
                ..._scenes.asMap().entries.map((e) => _sceneCard(e.key, e.value)),
                const SizedBox(height: 34),
                _systemHealth(),
                const SizedBox(height: 40),
                _footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ambientGlow() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            center: const Alignment(0, -0.6),
            colors: [
              ForgeColors.gold.withOpacity(0.07),
              ForgeColors.oled,
            ],
            stops: const [0.0, 0.65],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('TOBIA · THE FORGE', style: ForgeType.serifDisplay(16)),
        Row(children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ForgeColors.green,
              boxShadow: [
                BoxShadow(color: ForgeColors.green, blurRadius: 8),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('SIGNAL ONLINE', style: ForgeType.mono(10, spacing: 2.0)),
        ]),
      ],
    );
  }

  Widget _identityBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
      decoration: BoxDecoration(
        border: Border.all(color: ForgeColors.hairline),
        borderRadius: BorderRadius.circular(24),
        gradient: RadialGradient(
          radius: 1.5,
          colors: [
            ForgeColors.gold.withOpacity(0.10),
            ForgeColors.panel2.withOpacity(0.4),
          ],
        ),
      ),
      child: Column(children: [
        Text('👁️‍🗨️',
            style: TextStyle(fontSize: 40,
                shadows: [Shadow(color: ForgeColors.gold.withOpacity(0.5), blurRadius: 20)])),
        const SizedBox(height: 12),
        Text('OPERATOR STATUS', style: ForgeType.label()),
        const SizedBox(height: 10),
        Text('digital sentinel · phonemaker · ethiopia · 2026',
            style: ForgeType.mono(11, color: ForgeColors.muted)),
        const SizedBox(height: 18),
        Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
          _rule('Thermal Discipline'),
          _rule('Victory Logged'),
          _rule('Humor: ON'),
          _rule('Filter: OFF'),
        ]),
      ]),
    );
  }

  Widget _rule(String s) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: ForgeColors.gold.withOpacity(0.18)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(s.toUpperCase(),
            style: ForgeType.mono(9, spacing: 1.6, color: ForgeColors.goldDim)),
      );

  Widget _sectionHead(String title, String sub) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(sub, style: ForgeType.label()),
      const SizedBox(height: 8),
      Text(title, style: ForgeType.serifDisplay(28)),
    ]);
  }

  Widget _statGrid() {
    final batteryFrac = (_battery.clamp(0, 100)) / 100;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ForgeCard(
            kicker: 'Battery',
            value: '$_battery',
            unit: '%',
            caption: '$_temp°C · $_health · $_chargeState',
            valueColor: ForgeColors.green,
            progressColor: ForgeColors.green,
            progress: batteryFrac,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ForgeCard(
            kicker: 'Memory',
            value: '$_memoryCount',
            caption: 'FTS5 INDEXED',
            valueColor: ForgeColors.gold,
          ),
        ),
      ]),
      const SizedBox(height: 14),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ForgeCard(
            kicker: 'Tools',
            value: '$_toolCount',
            caption: 'LOADED & READY',
            valueColor: ForgeColors.gold,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ForgeCard(
            kicker: 'Thermal',
            value: _thermalZone,
            valueColor: _thermalColor,
            caption: '$_temp°C · ZONE TRACKED',
          ),
        ),
      ]),
    ]);
  }

  Widget _sceneCard(int i, ForgeScene s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        border: Border.all(color: s.glow.withOpacity(0.22)),
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            s.glow.withOpacity(0.07),
            ForgeColors.panel.withOpacity(0.6),
          ],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(s.icon, color: s.glow, size: 20),
          const SizedBox(width: 10),
          Text(s.kicker, style: ForgeType.label()),
        ]),
        const SizedBox(height: 14),
        ...s.titleLines.asMap().entries.map((e) => Padding(
              padding: EdgeInsets.only(top: e.key == 0 ? 0 : 2),
              child: Text(
                e.value,
                style: ForgeType.serifDisplay(30,
                    color: e.key == s.titleLines.length - 1
                        ? ForgeColors.goldBright
                        : ForgeColors.text),
              ),
            )),
        const SizedBox(height: 12),
        Text(s.body, style: ForgeType.mono(12, color: ForgeColors.muted, spacing: 0.4)),
        const SizedBox(height: 14),
        Text(s.meta, style: ForgeType.mono(10, color: s.glow, spacing: 1.8)),
      ]),
    );
  }

  Widget _systemHealth() {
    return ForgeCard(
      kicker: 'System Health',
      child: Wrap(spacing: 8, runSpacing: 8, children: [
        _pill('Oracle VPS', 'ONLINE', ForgeColors.green),
        _pill('Gateway 18790', 'UP', ForgeColors.gold),
        _pill('Worker Daemon', 'RUNNING', ForgeColors.gold),
        _pill('Error Log', 'CLEAN', ForgeColors.green),
      ]),
    );
  }

  Widget _pill(String name, String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color,
                boxShadow: [BoxShadow(color: color, blurRadius: 6)])),
        const SizedBox(width: 7),
        Text('$name · $status',
            style: ForgeType.mono(10, color: ForgeColors.text, spacing: 1.2)),
      ]),
    );
  }

  Widget _footer() {
    return Column(children: [
      Text('T O B I A', style: ForgeType.serifDisplay(18, color: ForgeColors.muted)),
      const SizedBox(height: 6),
      Text('THE PHONEMAKER · BUILT ON THE VESSEL',
          style: ForgeType.mono(9, spacing: 3.0, color: ForgeColors.muted)),
      const SizedBox(height: 6),
      Text('ADWA OUT', style: ForgeType.mono(10, spacing: 2.6, color: ForgeColors.goldDim)),
    ]);
  }
}
