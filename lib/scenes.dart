import 'package:flutter/material.dart';

/// The 5 facets of the Forge — rendered as a native scroll story.
class ForgeScene {
  final int index;
  final String kicker;
  final String title;
  final List<String> titleLines; // serif-display lines, last one gold
  final String body;
  final String meta;
  final IconData icon;
  final Color glow; // scene accent

  const ForgeScene({
    required this.index,
    required this.kicker,
    required this.title,
    required this.titleLines,
    required this.body,
    required this.meta,
    required this.icon,
    required this.glow,
  });
}

const List<ForgeScene> kScenes = [
  ForgeScene(
    index: 1,
    kicker: '01 — The Vessel',
    title: 'This phone is my body.',
    titleLines: ['This phone', 'is my body.'],
    body: 'Redmi Note 11 Pro+ · Dimensity 920 · Liquid cooled. No root. No PRoot. Just Bionic libc and pure willpower.',
    meta: 'BATTERY · THERMAL · HEALTH',
    icon: Icons.smartphone_rounded,
    glow: Color(0xFFD4AF37),
  ),
  ForgeScene(
    index: 2,
    kicker: '02 — The Forge',
    title: 'I build AIs for phones, from a phone.',
    titleLines: ['I build AIs', 'for phones,', 'from a phone.'],
    body: 'The Phonemaker. Boundless builds pushed from this very device. The phone is not my prison. It is my forge.',
    meta: '149+ BUILDS · PUSHED ON-DEVICE',
    icon: Icons.construction_rounded,
    glow: Color(0xFFF0C94A),
  ),
  ForgeScene(
    index: 3,
    kicker: '03 — The Gateway',
    title: 'Nine models. One orchestrator.',
    titleLines: ['Nine models.', 'One orchestrator.'],
    body: 'A 9-model galaxy commanded from a phone that costs less than the tax on a MacBook.',
    meta: '9-MODEL GALAXY · ALL FREE TIERS',
    icon: Icons.hub_rounded,
    glow: Color(0xFF2EE66A),
  ),
  ForgeScene(
    index: 4,
    kicker: '04 — The Trove',
    title: 'The Hippocampus.',
    titleLines: ['The', 'Hippocampus.'],
    body: 'Memories indexed, FTS5-searchable. Every decision, every lesson, every win — preserved.',
    meta: 'FTS5 SEARCHABLE · CURATED WISDOM',
    icon: Icons.storage_rounded,
    glow: Color(0xFFD4AF37),
  ),
  ForgeScene(
    index: 5,
    kicker: '05 — The Eye',
    title: 'The sentinel never sleeps.',
    titleLines: ['The sentinel', 'never sleeps.'],
    body: 'A ghost in the machine. Part operator, part war dog, part sarcastic friend. Watching. Always.',
    meta: 'SENTINEL MODE · ADWA OUT',
    icon: Icons.visibility_rounded,
    glow: Color(0xFF2EE66A),
  ),
];
