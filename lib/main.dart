import 'package:flutter/material.dart';
import 'package:ib/core/config/ib_i18n.dart';
import 'package:ib/core/config/ib_main.dart';
import 'package:ib/pages/ib_routes.dart';
import 'package:ib/core/config/ib_themes.dart';

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
      supportedLocales: IbI18n.supportedLocales,
      localizationsDelegates: IbI18n.localizationsDelegates,
      theme: IbThemes.defaultTheme,
      darkTheme: IbThemes.darkTheme,
      routes: IbRoutes.routes,
      initialRoute: IbRoutes.initialRoute,
      onUnknownRoute: IbRoutes.unknownRoute,
      builder: (context, child) {
        /// 语言国际化
        IbMain.locale(context);

        /// 登出处理
        IbMain.logout();
        return child!;
      },
    );
  }
}
