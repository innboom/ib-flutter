import 'package:flutter/material.dart';
import 'package:play_music/core/config/pm_i18n.dart';
import 'package:play_music/core/config/pm_main.dart';
import 'package:play_music/pages/pm_routes.dart';
import 'package:play_music/core/config/pm_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Music Play',
      supportedLocales: PmI18n.supportedLocales,
      localizationsDelegates: PmI18n.localizationsDelegates,
      theme: PmThemes.defaultTheme,
      darkTheme: PmThemes.darkTheme,
      routes: PmRoutes.routes,
      initialRoute: PmRoutes.initialRoute,
      onUnknownRoute: PmRoutes.unknownRoute,
      builder: (context, child) {
        /// 语言国际化
        PmMain.locale(context);

        /// 登出处理
        PmMain.logout();
        return child!;
      },
    );
  }
}
