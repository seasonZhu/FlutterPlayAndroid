import 'package:flutter/material.dart';

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class LoginEvent {}
class LogoutEvent {}

class ChangeThemeEvent {

  Color color;

  ChangeThemeEvent(this.color);

}