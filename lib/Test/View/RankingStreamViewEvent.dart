/// 页面事件枚举
enum ActionType { refresh, pullUp }

/// 页面事件基类
abstract class StreamEvent {}

/// 请求页面数据事件类
class FetchDataEvent implements StreamEvent {
  final ActionType type;

  FetchDataEvent({this.type});

  @override
  String toString() {
    return 'FetchDataEvent { action: ${type == ActionType.refresh ? "刷新" : "上拉"} }';
  }
}