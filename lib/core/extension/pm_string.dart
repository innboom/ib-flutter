import 'package:play_music/core/config/pm_i18n.dart';

// 扩展 String 类来获取翻译
extension PmString on String {
  static final _intlHost = IntlHost.instance;

  // 文字国际化的增强方法
  String get i18n {
    // 使用 _intlHost 获取翻译
    return _intlHost.getTranslation(this);
  }
}
