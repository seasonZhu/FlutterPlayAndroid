import 'dart:ui';
//import 'package:device_info/device_info.dart';

abstract class DeviceSize {

  /// 基准宽度 单位px
  static var baseWidth = 1080;

  /// 通过物理屏宽与基准baseWidth(默认1080px),计算相对px系数,如果想要更换基准,在项目开始的时候就进行设置,后面不要在进行变动
  static double get rpx => physicalWidth / baseWidth ;

  /// 屏宽 单位pt
  static double get screenWidth => physicalWidth / dpr;

  /// 屏高 单位pt
  static double get screenHeight => physicalHeight / dpr;

  /// 屏的长宽 单位pt
  static Size get size => Size(screenWidth, screenHeight);

  /// 屏状态栏高度 单位pt
  static double get statusBarHeight => physicalStatusBarHeight / dpr;

  /// 屏底部间距 单位pt
  static double get bottomPadding => physicalBottomPadding / dpr;

  /// 屏幕物理宽度 单位px
  static double get physicalWidth => window.physicalSize.width;

  /// 屏幕物理高度 单位px
  static double get physicalHeight => window.physicalSize.height;

  /// 屏幕物理宽高 单位px
  static Size get physicalSize => window.physicalSize;

  /// 屏幕物理状态栏高度 单位px
  static double get physicalStatusBarHeight => window.viewPadding.top;

  /// 屏幕物理底部间距 单位px
  static double get physicalBottomPadding => window.viewPadding.bottom;

  /// devicePixelRatio 单位px
  static double get dpr => window.devicePixelRatio;
    
  /// 按照rpx来设置
  static double setRpx(double size) => DeviceSize.rpx * size;
}

/* int分类 */
extension IntFit on int {
  double get rpx => DeviceSize.setRpx(this.toDouble());
}

/* double分类 */
extension DoubleFit on double {
  double get rpx => DeviceSize.setRpx(this);
}