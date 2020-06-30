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
class StreamState {}

class InitializedState extends StreamState {}

class LoadingState extends StreamState {}

class HasData extends StreamState {
  final List<DataElement> data;

  final RequestCompleteState completeType;

  HasData({this.data, this.completeType});

  bool get hasData => data.length > 0;
}

class NoDataState extends StreamState {}

class ErrorState extends StreamState {}