import 'package:ib/core/config/ib_screen.dart';

extension IbDouble on double {
  double get px {
    return IbScreen.setPx(this);
  }

  double get rpx {
    return IbScreen.setRpx(this);
  }
}
