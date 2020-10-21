import 'package:flutter/material.dart';

import 'package:event_bus/event_bus.dart';

// 总线
final EventBus eventBus = EventBus();

// 登录事件
class LoginEvent {}

// 登出事件
class LogoutEvent {}

// 改变主题颜色(仅对白天模式有效)
class ChangeThemeEvent {

  final Color color;

  ChangeThemeEvent(this.color);

}

// 白天模式或者是黑暗模式
class ChangeThemeBrightness {
  final Brightness brightnessType;
  
  ChangeThemeBrightness(this.brightnessType);
}