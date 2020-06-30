import 'dart:async';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/RankListResponse.dart';

import 'RankingStreamViewEvent.dart';
import 'RankingStreamViewState.dart';


/// ViewModel层
class RankingStreamViewModel {
  final StreamController<StreamState> _stateController =
      StreamController<StreamState>();

  List<DataElement> data = [];

  num _page = 1;

  Stream<StreamState> get streamState => _stateController.stream;

  void dispatch(StreamEvent event) {
    print('Event dispatched: $event');
    if (event is FetchDataEvent) {
      _request(event.type);
    }
  }

  void _request(ActionType type) {
    switch (type) {
      case ActionType.refresh:
        _onRefresh();
        break;
      case ActionType.pullUp:
        _onLoading();
        break;
    }
  }

  Future<RankListResponse> _getRankList() async {
    var model = await Request.getRankingList(page: _page);
    return model;
  }

  Future _onRefresh() async {
    _page = 1;
    var model = await _getRankList();
    if (model.errorCode == 0) {
      data.clear();
      data.addAll(model.data.datas);
      if (data.length > 0) {
        return _stateController.add(HasData(
            completeType: RequestCompleteState.refreshCompleted,
            data: data));
      } else {
        return _stateController.add(NoDataState());
      }
    } else {
      return _stateController.add(ErrorState());
    }
  }

  Future _onLoading() async {
    _page = _page + 1;
    var model = await _getRankList();
    if (model.errorCode == 0) {
      data.addAll(model.data.datas);
      if (model.data.pageCount == model.data.curPage) {
        return _stateController.add(HasData(
            completeType: RequestCompleteState.loadNoData,
            data: data));
      } else {
        return _stateController.add(HasData(
            completeType: RequestCompleteState.loadComplete,
            data: data));
      }
    } else {
      return _stateController.add(HasData(
          completeType: RequestCompleteState.loadComplete,
          data: []));
    }
  }
}