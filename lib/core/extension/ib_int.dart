import 'package:ib/core/config/ib_screen.dart';

extension IbInt on int {
  double get px {
    return IbScreen.setPx(toDouble());
  }

  double get rpx {
    return IbScreen.setRpx(toDouble());
  }
}
