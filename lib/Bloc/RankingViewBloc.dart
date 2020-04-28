import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/RankListResponse.dart';

enum RankingViewEvent { onRefresh, onLoading }

class RankingViewState{
  int _page;

  get page => _page;

  List<DataElement> _dataSource;

  get  dataSource => _dataSource;

  RankingViewState(this._page, this._dataSource);

}

class RankingViewBloc extends Bloc<RankingViewEvent,RankingViewState>{

  var _page = 1;

  var _dataSource = List<DataElement>();

  @override
  RankingViewState get initialState => RankingViewState(1,[]);

  @override
  Stream<RankingViewState> mapEventToState(RankingViewEvent event) async *{
    RankListResponse model;
    switch (event) {
      case RankingViewEvent.onRefresh:
        _dataSource.clear();
        _page = 1;
        break;
      case RankingViewEvent.onLoading:
        _page = _page + 1;
        break;
    }
    model = await Request.getRankingList(page: _page);

    _dataSource.addAll(model.data.datas);
    yield RankingViewState(_page, _dataSource);
  }
}