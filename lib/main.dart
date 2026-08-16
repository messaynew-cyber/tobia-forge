import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screens/forge_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ForgeColors.bg0,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: ForgeColors.bg0,
  ));
  runApp(const ForgeApp());
}

class ForgeApp extends StatelessWidget {
  const ForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOBIA — The Forge 2.0',
      debugShowCheckedModeBanner: false,
      theme: buildForgeTheme(),
      home: const ForgeScreen(),
    );
  }
}
