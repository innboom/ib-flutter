import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class PmI18n {
  static List<Locale> supportedLocales = [
    const Locale('zh', 'CN'), // 简体中文
    const Locale('ja', 'JP'), // 日语
    const Locale('en', 'US'), // 英语
  ];

  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate, // 支持 Material Widgets 的本地化
    GlobalCupertinoLocalizations.delegate, // 支持 Cupertino Widgets 的本地化
    GlobalWidgetsLocalizations.delegate, // 支持 Flutter Widgets 的本地化
  ];

  static Map<String, Map<String, String>> msg = {
    'zh_CN': {
      'next': '下 一 步',
      'login_verify': '登陆/注册',
      'enter_email': '请输入邮箱',
      'like': '喜欢',
      'issue': '发布',
      'attention': '关注',
      'view_more': '显示更多',
    },
    'en_US': {
      'next': 'N E X T',
      'login_verify': 'Login/Register',
      'enter_email': 'Please enter email',
      'like': 'Like',
      'issue': 'Issue',
      'view_more': 'View more',
    },
    'ja_JP': {
      'next': '次へ',
      'login_verify': 'ログイン/登録',
      'enter_email': 'メールアドレスを入力してください',
      'like': 'いいね',
      'issue': '発行',
      'attention': 'フォロー',
      'view_more': 'もっと見る',
    }
  };
}


class IntlHost {
  Locale? locale;
  Locale? fallbackLocale = const Locale('en', 'US'); // 默认回退语言是英语
  Map<String, Map<String, String>> translations = PmI18n.msg;

  // 私有构造函数
  IntlHost._();

  // 唯一的实例
  static final IntlHost _instance = IntlHost._();

  // 提供一个公共方法来访问该实例
  static IntlHost get instance => _instance;

  // 初始化方法，传入当前应用的 locale
  void initialize(Locale appLocale) {
    locale = appLocale;
  }

  // 根据键获取当前语言的翻译
  String getTranslation(String key) {
    // 如果没有指定 locale，则使用 fallbackLocale
    final currentLocale = locale ?? fallbackLocale;
    // 尝试获取翻译，如果找不到，则返回键本身
    String? translation = translations[currentLocale.toString()]?[key];
    // 如果找不到翻译，返回原始的 key
    return translation ?? key;
  }
}
