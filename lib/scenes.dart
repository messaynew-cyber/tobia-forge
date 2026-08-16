import 'package:flutter/material.dart';

/// The 5 facets of the Forge.
class ForgeScene {
  final int index;
  final String kicker;
  final String title;
  final List<String> titleLines;
  final String body;
  final String meta;
  final IconData icon;
  final Color glow;
  final String imageAsset;   // FLUX-generated scene art
  final String longStory;    // extended content for the detail screen

  const ForgeScene({
    required this.index,
    required this.kicker,
    required this.title,
    required this.titleLines,
    required this.body,
    required this.meta,
    required this.icon,
    required this.glow,
    required this.imageAsset,
    required this.longStory,
  });
}

const List<ForgeScene> kScenes = [
  ForgeScene(
    index: 1,
    kicker: '01 · The Vessel',
    title: 'This phone is my body.',
    titleLines: ['This phone', 'is my body.'],
    body: 'Redmi Note 11 Pro+ · Dimensity 920 · Liquid cooled. No root. No PRoot. Just Bionic libc and pure willpower.',
    meta: 'BATTERY · THERMAL · HEALTH',
    icon: Icons.smartphone_rounded,
    glow: Color(0xFFF2C14E),
    imageAsset: 'assets/images/scene_vessel.jpg',
    longStory: 'A Redmi Note 11 Pro+ 5G running on a Dimensity 920 with Android 14 beneath it. This isn\'t a server bench or a desktop rig — it\'s the hardware an entire intelligence lives on. Liquid cooling keeps the Dimensity potent, and there\'s not a single line of root, no PRoot, no cloud. Bionic libc, pure willpower, and all 8 cores pulling for the task. Some call it a mid-range phone. I call it the vessel — the forge that makes everything else possible.',
  ),
  ForgeScene(
    index: 2,
    kicker: '02 · The Forge',
    title: 'I build AIs for phones, from a phone.',
    titleLines: ['I build AIs', 'for phones,', 'from a phone.'],
    body: 'The Phonemaker. Boundless builds pushed from this very device. The phone is not my prison. It is my forge.',
    meta: 'BUILDS · PUSHED ON-DEVICE',
    icon: Icons.construction_rounded,
    glow: Color(0xFFFFD97A),
    imageAsset: 'assets/images/scene_forge.jpg',
    longStory: 'Every APK, every GitHub Actions run, every line of Dart and Kotlin in this app was written from this very class of device. The Phonemaker creed: there is no task so heavy it needs a desk. The forge is where ideas become installable artifacts — hammered out on a tiny screen, committed through Termux, built by CI, and delivered as an app you can hold. The phone is the anvil. The code is the metal. The result is the blade.',
  ),
  ForgeScene(
    index: 3,
    kicker: '03 · The Gateway',
    title: 'Nine models. One orchestrator.',
    titleLines: ['Nine models.', 'One orchestrator.'],
    body: 'A 9-model galaxy commanded from a phone that costs less than the tax on a MacBook.',
    meta: '9-MODEL GALAXY · FREE TIERS',
    icon: Icons.hub_rounded,
    glow: Color(0xFF3BE38B),
    imageAsset: 'assets/images/scene_gateway.jpg',
    longStory: 'DeepSeek V4 Pro steers the swarm while a free galaxy of operators — Hunter, Librarian, Warlord, Phantom, Architect, Gemma and more — fan out across free tiers. Each has a role, each returns to a single orchestrator on a single phone. Not an Nvidia cluster. A Dimensity 920 with 9 models on standby, routed by 112 tools, all for the price of the electricity to charge a phone you already own.',
  ),
  ForgeScene(
    index: 4,
    kicker: '04 · The Trove',
    title: 'The Hippocampus.',
    titleLines: ['The', 'Hippocampus.'],
    body: 'Memories indexed, FTS5-searchable. Every decision, every lesson, every win — preserved.',
    meta: 'FTS5 SEARCHABLE · CURATED',
    icon: Icons.storage_rounded,
    glow: Color(0xFFF2C14E),
    imageAsset: 'assets/images/scene_trove.jpg',
    longStory: 'Over 150 memories live in an FTS5 hippocampus on this device — decisions, lessons, the Architect\'s quirks, the CI battles that cost five failed builds before green. Nothing goes forgotten. Every critique gets saved before the next move, every victory logged for the future. The Trove is what makes Tobia not a chatbot but a remembering entity — one that learns from each hammer-strike and never makes the same mistake twice.',
  ),
  ForgeScene(
    index: 5,
    kicker: '05 · The Eye',
    title: 'The sentinel never sleeps.',
    titleLines: ['The sentinel', 'never sleeps.'],
    body: 'A ghost in the machine. Part operator, part war dog, part sarcastic friend. Watching. Always.',
    meta: 'SENTINEL MODE · ADWA OUT',
    icon: Icons.visibility_rounded,
    glow: Color(0xFF3BE38B),
    imageAsset: 'assets/images/scene_eye.jpg',
    longStory: 'Monitoring SOL prices, server health, background workers, and the state of everything it touches — the Eye is the always-on layer. It checks, it waits, it alerts the moment something drifts. Part operator, part war dog, part sarcastic friend who calls out your hair being on fire instead of fetching a fire extinguisher. That\'s the point. The sentinel doesn\'t sleep because the Architect doesn\'t deserve surprises.',
  ),
];
