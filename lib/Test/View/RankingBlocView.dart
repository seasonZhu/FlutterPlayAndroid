import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/RankListResponse.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ErrorView.dart';
import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/My/RankingCell.dart';

/// 页面事件
enum RankingViewEvent { refresh, pullUp }

/// 页面状态
enum RankingViewState {
  loading,
  hasDataRefreshComplete,
  hasDataPullUpComplete,
  hasDataPullUpNoMoreData,
  noData,
  error
}

/// 页面状态数据
class RankingViewStateData {
  List<DataElement> dataSource;

  RankingViewState state;

  RankingViewStateData({this.dataSource, this.state});
}

/// 页面Bloc
class RankingBloc extends Bloc<RankingViewEvent, RankingViewStateData> {
  num _page = 1;

  List<DataElement> _dataSource = [];

  @override
  RankingViewStateData get initialState => RankingViewStateData(
      state: RankingViewState.hasDataRefreshComplete, dataSource: []);

  @override
  Stream<RankingViewStateData> mapEventToState(RankingViewEvent event) async* {
    switch (event) {
      case RankingViewEvent.refresh:
        yield await _onRefresh();
        break;
      case RankingViewEvent.pullUp:
        yield await _onLoading();
        break;
    }
  }

  Future<RankListResponse> _getRankList() async {
    var model = await Request.getRankingList(page: _page);
    return model;
  }

  Future<RankingViewStateData> _onRefresh() async {
    _page = 1;
    var model = await _getRankList();
    if (model.errorCode == 0) {
      _dataSource.clear();
      _dataSource.addAll(model.data.datas);
      if (_dataSource.length > 0) {
        state.state = RankingViewState.hasDataRefreshComplete;
        state.dataSource = _dataSource;
      } else {
        state.state = RankingViewState.noData;
        state.dataSource = [];
      }
    } else {
      state.state = RankingViewState.error;
      state.dataSource = [];
    }
    return state;
  }

  Future<RankingViewStateData> _onLoading() async {
    _page = _page + 1;
    var model = await _getRankList();
    if (model.errorCode == 0) {
      if (model.data.pageCount == model.data.curPage) {
        state.state = RankingViewState.hasDataPullUpNoMoreData;
        state.dataSource = _dataSource;
      } else {
        state.state = RankingViewState.hasDataPullUpComplete;
        state.dataSource = _dataSource;
      }
    } else {
      state.state = RankingViewState.hasDataPullUpComplete;
      state.dataSource = [];
    }
    return state;
  }
}

class RankingBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranking Bloc',
      home: BlocProvider(
        create: (_) => RankingBloc(),
        child: RankingBlocView(),
      ),
    );
  }
}

class RankingBlocView extends StatefulWidget {
  @override
  _RankingBlocViewState createState() => _RankingBlocViewState();
}

class _RankingBlocViewState extends State<RankingBlocView> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("排行榜", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: BlocBuilder<RankingBloc, RankingViewStateData>(
        builder: (_, stateData) {
          switch (stateData.state) {
            case RankingViewState.loading:
              return LoadingView();
              break;
            case RankingViewState.error:
              return ErrorView();
              break;
            case RankingViewState.noData:
              return EmptyView();
              break;
            case RankingViewState.hasDataRefreshComplete:
              _refreshController.refreshCompleted();
              break;
            case RankingViewState.hasDataPullUpNoMoreData:
              _refreshController.loadNoData();
              break;
            case RankingViewState.hasDataPullUpComplete:
              _refreshController.loadComplete();
              break;
          }
          return SafeArea(
            child: SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return RankingCell(model: stateData.dataSource[index]);
                },
                itemCount: stateData.dataSource.length,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onRefresh() {
    context.bloc<RankingBloc>().add(RankingViewEvent.refresh);
  }

  void _onLoading() {
    context.bloc<RankingBloc>().add(RankingViewEvent.pullUp);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
