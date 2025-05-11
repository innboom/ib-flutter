import 'package:play_music/core/config/pm_screen.dart';

extension PmDouble on double {
  double get px {
    return PmScreen.setPx(this);
  }

  double get rpx {
    return PmScreen.setRpx(this);
  }
}
