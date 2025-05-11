import 'package:flutter/material.dart';
import 'package:play_music/core/config/pm_i18n.dart';
import 'package:play_music/core/event_bus.dart';
import 'package:play_music/pages/home/pm_home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PmMain {
  // 监听语言变化
  static Locale? _currentLocale;

  /// 国际化语言处理
  static void locale(BuildContext context) {
    final newLocale = Localizations.localeOf(context);
    // 如果语言变化，强制退出应用
    if (_currentLocale != null && _currentLocale != newLocale) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        PmHomePage.routeName,
        (route) => false, // 清空所有页面
      );
    }
    // 更新当前语言
    _currentLocale = newLocale;
    // 初始化语言环境
    IntlHost.instance.initialize(newLocale);
  }

  /// 登出事件处理

  // 用于处理登出事件的逻辑
  static void logout() {
    // 监听事件并通过 navigatorKey 跳转页面
    EventBus.instance.addListener<String>(EventKeys.logout, (data) {
      // 使用 navigatorKey 进行页面跳转，清空历史页面栈
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        PmHomePage.routeName,
        (route) => false, // 清空所有页面
      );
    });
  }
}
