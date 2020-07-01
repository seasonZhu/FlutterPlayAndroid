import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/My/RankingCell.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ErrorView.dart';
import 'package:play_android/Compose/LoadingView.dart';
import 'RankingStreamViewState.dart';
import 'RankingStreamViewEvent.dart';
import 'RankingStreamViewModel.dart';

class RankingStreamView extends StatefulWidget {
  @override
  _RankingStreamViewState createState() => _RankingStreamViewState();
}

class _RankingStreamViewState extends State<RankingStreamView> {
  final _viewModel = RankingStreamViewModel();

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _viewModel.dispatch(FetchDataEvent(type: ActionType.refresh));
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
      body: StreamBuilder(
        stream: _viewModel.stream,
        builder: (buildContext, snapshot) {
          /// snapshot的hasError
          if (snapshot.hasError) {
            return ErrorView();
          }

          if (snapshot.data == null) {
            return LoadingView();
          }

          /// 通过snapshot.data进行界面构建
          var streamState = snapshot.data;

          if (streamState is InitializedState) {
            return LoadingView();
          }

          if (streamState is LoadingState) {
            return LoadingView();
          }

          if (streamState is HasData) {
            if (!streamState.hasData) {
              return EmptyView();
            }

            switch (streamState.completeType) {
              case RequestCompleteState.refreshCompleted:
                _refreshController.refreshCompleted();
                break;
              case RequestCompleteState.loadComplete:
                _refreshController.loadComplete();
                break;
              case RequestCompleteState.loadNoData:
                _refreshController.loadNoData();
                break;
            }
          }

          if (streamState is NoDataState) {
            return EmptyView();
          }

          if (streamState is ErrorState) {
            return ErrorView();
          }

          return SafeArea(
            child: SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return RankingCell(model: streamState.data[index]);
                },
                itemCount: streamState.data.length,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onRefresh() {
    _viewModel.dispatch(FetchDataEvent(type: ActionType.refresh));
  }

  void _onLoading() {
    _viewModel.dispatch(FetchDataEvent(type: ActionType.pullUp));
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
