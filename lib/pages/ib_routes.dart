import 'package:flutter/material.dart';
import 'package:ib/pages/demo/musice_test.dart';
import 'package:ib/pages/home/ib_home_page.dart';
import 'package:ib/pages/unknown/ib_unknown_page.dart';

class IbRoutes {
  static const String initialRoute = IbHomePage.routeName;

  /* 所有页面路由 */
  static final Map<String, WidgetBuilder> routes = {
    initialRoute: (ctx) => const IbHomePage(),
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
    return MaterialPageRoute(builder: (ctx) => const IbUnknownPage());
  };
}
