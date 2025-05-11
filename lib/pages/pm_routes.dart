import 'package:flutter/material.dart';
import 'package:play_music/pages/demo/musice_test.dart';
import 'package:play_music/pages/home/pm_home_page.dart';
import 'package:play_music/pages/unknown/pm_unknown_page.dart';

class PmRoutes {
  static const String initialRoute = PmHomePage.routeName;

  /* 所有页面路由 */
  static final Map<String, WidgetBuilder> routes = {
    initialRoute: (ctx) => const PmHomePage(),
    // initialRoute: (ctx) => const MusicPlayerPage(),
  };

  /* 需要自定义路由 */
  // ignore: prefer_function_declarations_over_variables
  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  /* 未定义页面统一跳转路由 */
  // ignore: prefer_function_declarations_over_variables
  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(builder: (ctx) => const PmUnknownPage());
  };
}
