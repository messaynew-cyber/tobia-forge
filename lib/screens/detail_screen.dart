import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../widgets/forge_surface.dart';
import '../widgets/animated.dart';

/// Extended info screen — opened by tapping a dashboard tile.
class DetailScreen extends StatefulWidget {
  final int battery; final double temp; final String health; final String charge;
  final int mem; final int tools;
  const DetailScreen({super.key, required this.battery, required this.temp,
    required this.health, required this.charge, required this.mem, required this.tools});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _fill = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..forward();
  late final AnimationController _pump = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500))..repeat(reverse: true);
  @override
  void dispose(){ _fill.dispose(); _pump.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.bg0,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: ForgeColors.bg0,
            leading: _backButton(),
            flexibleSpace: FlexibleSpaceBar(
              background: _headerArt(),
            ),
          ),
          SliverPadding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 40), sliver: SliverList.list(children: [
            _title(),
            const SizedBox(height: 20),
            _primaryStat(),
            const SizedBox(height: 20),
            _systemMetrics(),
            const SizedBox(height: 24),
            _thermalGuide(),
            const SizedBox(height: 30),
            _actions(),
          ])),
        ],
      ),
    );
  }

  Widget _backButton() => Padding(
    padding: const EdgeInsets.all(6),
    child: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_rounded, color: ForgeColors.text),
      style: IconButton.styleFrom(backgroundColor: ForgeColors.bg2.withOpacity(0.7)),
    ),
  );

  Widget _headerArt() {
    // gradient art band for the detail header
    return Stack(fit: StackFit.expand, children: [
      DecoratedBox(decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [ForgeColors.bg1, ForgeColors.bg0]),
      )),
      Positioned(top: -50, right: -50, child: Container(width: 220, height: 220,
        decoration: BoxDecoration(shape: BoxShape.circle,
          gradient: RadialGradient(colors: [ForgeColors.gold.withOpacity(0.16), Colors.transparent])))),
      Align(alignment: Alignment.bottomLeft, child: Padding(padding: const EdgeInsets.only(left: 20, bottom: 16),
        child: Icon(Icons.settings_suggest_rounded, color: ForgeColors.gold, size: 54))),
    ]);
  }

  Widget _title() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SlideReveal(child: Text('OPERATOR · DETAIL', style: ForgeType.kicker(color: ForgeColors.gold))),
      const SizedBox(height: 8),
      SlideReveal(child: Text('System Forensics', style: ForgeType.hero(32))),
      const SizedBox(height: 6),
      Text('live readout · ${widget.battery}% · ${widget.temp}°C · ${widget.health}',
          style: ForgeType.mono(11, color: ForgeColors.muted)),
    ]);
  }

  Widget _primaryStat() {
    final frac = widget.battery / 100;
    return ForgeSurface(raised: true, glow: ForgeColors.emerald, glowStrength: 0.2, padding: const EdgeInsets.all(24),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BATTERY CHARGE', style: ForgeType.kicker(color: ForgeColors.emerald)),
          const SizedBox(height: 10),
          AnimatedBuilder(animation: _fill, builder: (_, __) {
            final v = _fill.value;
            return Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              Text('${(widget.battery * v).round()}', style: ForgeType.hero(72)),
              const SizedBox(width: 4),
              Text('%', style: ForgeType.mono(20, color: ForgeColors.emerald)),
            ]);
          }),
          const SizedBox(height: 12),
          ClipRRect(borderRadius: BorderRadius.circular(6), child: Container(height: 8, color: ForgeColors.bg3,
            child: AnimatedBuilder(animation: _fill, builder: (_, __) => FractionallySizedBox(
              alignment: Alignment.centerLeft, widthFactor: frac * _fill.value,
              child: Container(decoration: BoxDecoration(
                gradient: LinearGradient(colors: [ForgeColors.emeraldDeep, ForgeColors.emerald]),
                borderRadius: BorderRadius.circular(6))))))),
        ])),
        const SizedBox(width: 16),
        AnimatedBuilder(animation: _pump, builder: (_, __) => Container(
          width: 92, height: 92,
          decoration: BoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: ForgeColors.emerald.withOpacity(0.4), width: 3),
            boxShadow: [BoxShadow(color: ForgeColors.emerald.withOpacity(0.18 * _pump.value), blurRadius: 28, spreadRadius: 8)],
          ),
          child: Center(child: Text('${widget.battery}', style: ForgeType.hero(30, color: ForgeColors.emerald))),
        )),
      ]));
  }

  Widget _systemMetrics() {
    return ForgeSurface(padding: const EdgeInsets.all(20), child: Column(children: [
      _metricRow('TEMPERATURE', '${widget.temp.toStringAsFixed(1)}°C', _tempColor(), Icons.thermostat_rounded),
      _divider(),
      _metricRow('HEALTH', widget.health, _healthColor(), Icons.monitor_heart_rounded),
      _divider(),
      _metricRow('CHARGE MODE', widget.charge, ForgeColors.gold, Icons.bolt_rounded),
      _divider(),
      _metricRow('MEMORY', '${widget.mem} ENTRIES', ForgeColors.gold, Icons.storage_rounded),
      _divider(),
      _metricRow('TOOLS', '${widget.tools} LOADED', ForgeColors.sky, Icons.widgets_rounded),
    ]));
  }

  Widget _metricRow(String label, String val, Color color, IconData icon) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 12),
      Expanded(child: Text(label, style: ForgeType.kicker(color: ForgeColors.muted))),
      Text(val, style: ForgeType.mono(15, color: color)),
    ]));
  }
  Widget _divider() => Divider(height: 1, color: ForgeColors.glassBorder, thickness: 1);

  Color _tempColor() { if (widget.temp > 40) return ForgeColors.crimson; if (widget.temp>35) return ForgeColors.gold; return ForgeColors.emerald; }
  Color _healthColor() { if (widget.health=='GOOD') return ForgeColors.emerald; if (widget.health=='WARM') return ForgeColors.gold; return ForgeColors.crimson; }

  Widget _thermalGuide() {
    final zones = [('DISCIPLINED', '<35°C', ForgeColors.emerald), ('THROTTLED', '35-40°', ForgeColors.gold), ('CRITICAL', '>40°C', ForgeColors.crimson)];
    return ForgeSurface(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('THERMAL ZONES', style: ForgeType.kicker(color: ForgeColors.gold)),
      const SizedBox(height: 14),
      Row(children: zones.map((z) => Expanded(child: Column(children: [
        for (int i=0;i<3;i++) Container(width: 6, height: 6, margin: const EdgeInsets.only(bottom:3),
          decoration: BoxDecoration(shape: BoxShape.circle, color: z.$3.withOpacity(0.5))),
        const SizedBox(height: 6),
        Text(z.$1, style: ForgeType.mono(9, color: ForgeColors.textSoft), textAlign: TextAlign.center),
        Text(z.$2, style: ForgeType.mono(8, color: ForgeColors.muted), textAlign: TextAlign.center),
      ]))).toList()),
      const SizedBox(height: 14),
      Text('CURRENT: ${widget.temp}°C → ${_zoneLabel()}', style: ForgeType.mono(11, color: _tempColor())),
    ]));
  }
  String _zoneLabel() { if (widget.temp>40) return 'CRITICAL'; if (widget.temp>35) return 'THROTTLED'; return 'DISCIPLINED'; }

  Widget _actions() {
    return Column(children: [
      ForgeSurface(onTap: () => Navigator.pop(context), padding: const EdgeInsets.all(16), child: Row(children: [
        Icon(Icons.refresh_rounded, color: ForgeColors.emerald, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text('Refresh live stats', style: ForgeType.body())),
      ])),
    ]);
  }
}
