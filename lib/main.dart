import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screens/forge_screen.dart';
import 'screens/scenes_list_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: ForgeColors.bg0,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const ForgeApp());
}

class ForgeApp extends StatelessWidget {
  const ForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOBIA — The Forge 3.0',
      debugShowCheckedModeBanner: false,
      theme: buildForgeTheme(),
      themeMode: ThemeMode.dark,
      home: const ForgeShell(),
    );
  }
}

/// Root shell — bottom nav for a true multi-page app.
class ForgeShell extends StatefulWidget {
  const ForgeShell({super.key});
  @override
  State<ForgeShell> createState() => _ForgeShellState();
}

class _ForgeShellState extends State<ForgeShell> {
  int _tab = 0;
  late final List<Widget> _pages = const [
    ForgeScreen(),
    ScenesListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ForgeColors.bg0,
      body: IndexedStack(index: _tab, children: _pages),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget _navBar() {
    return Container(
      decoration: BoxDecoration(
        color: ForgeColors.bg1.withOpacity(0.95),
        border: Border(top: BorderSide(color: ForgeColors.glassBorder, width: 1)),
      ),
      child: SafeArea(top: false, child: Row(children: [
        _navItem(0, Icons.dashboard_rounded, 'FORGE'),
        _navItem(1, Icons.grid_view_rounded, 'SCENES'),
        _navItem(2, Icons.tune_rounded, 'SETTINGS'),
      ])),
    );
  }

  Widget _navItem(int idx, IconData icon, String label) {
    final active = _tab == idx;
    return Expanded(child: InkWell(
      onTap: () => setState(() => _tab = idx),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AnimatedContainer(duration: const Duration(milliseconds: 300), curve: const Cubic(0.16,1,0.3,1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            decoration: BoxDecoration(
              color: active ? ForgeColors.gold.withOpacity(0.14) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: active ? ForgeColors.gold : ForgeColors.faint, size: 22)),
          const SizedBox(height: 3),
          Text(label, style: ForgeType.mono(9, color: active ? ForgeColors.gold : ForgeColors.faint)),
        ])),
    ));
  }
}
