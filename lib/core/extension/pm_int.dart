import 'package:play_music/core/config/pm_screen.dart';

extension PmInt on int {
  double get px {
    return PmScreen.setPx(toDouble());
  }

  double get rpx {
    return PmScreen.setRpx(toDouble());
  }
}
