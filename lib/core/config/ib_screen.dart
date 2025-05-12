import 'dart:ui';

import 'dart:ui';

class IbScreen {
  static double? physicalWidth;
  static double? physicalHeight;
  static double? screenWidth;
  static double? screenHeight;
  static double? dpr;
  static double? statusHeight;
  static double? rpx;
  static double? px;

  static void initialize() {
    // 1、手机物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    // 2、获取dpr
    dpr = window.devicePixelRatio;

    // 3、宽度和高度
    screenWidth = physicalWidth! / dpr!;
    screenHeight = physicalHeight! / dpr!;

    // 4、状态栏高度
    statusHeight = window.padding.top / dpr!;

    rpx = screenWidth! / 750;
    px = (screenWidth! / 750) * 2;
  }

  static double setRpx(double size) {
    return size * rpx!;
  }

  static double setPx(double size) {
    return size * px!;
  }
}
