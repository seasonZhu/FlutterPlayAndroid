import 'package:play_android/Responses/RankListResponse.dart';

/// 页面状态
enum ViewState { loading, hasData, noData, error }

/// 下拉刷新完成, 上拉加载完成没有数据, 上拉加载完成
enum RequestCompleteState {
  refreshCompleted,
  loadNoData,
  loadComplete
}

/// 由页面状态衍生出来的StreamState及其对应的State
abstract class StreamState {}

class InitializedState implements StreamState {}

class LoadingState implements StreamState {}

/// 其实这里我甚至可以细化HasData的状态类,以分清楚是刷新完成/上拉完成/上拉完成没有更多数据
class HasData implements StreamState {
  final List<DataElement> data;

  final RequestCompleteState completeType;

  HasData({this.data, this.completeType});

  bool get hasData => data.length > 0;
}

class NoDataState implements StreamState {}

class ErrorState implements StreamState {}