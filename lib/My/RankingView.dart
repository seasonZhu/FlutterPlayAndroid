import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/RankListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
//import 'package:play_android/Compose/EmptyView.dart';

import 'RankingCell.dart';

class RankingView extends StatefulWidget {
  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  var _page = 1;

  var _dataSource = List<DataElement>();

  var _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getRankList(_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("排行榜", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: _contentView(context, _dataSource),
    );
  }

  Widget _contentView(BuildContext context, List<DataElement> dataSoures) {
    if (dataSoures.length == 0) {
      return LoadingView();
    } else {
      return SafeArea(child: _listView(context, dataSoures));
    }
  }

  Widget _listView(BuildContext context, List<DataElement> dataSoures) {
    return SmartRefresher(
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return RankingCell(model: dataSoures[index]);
        },
        itemCount: dataSoures.length,
      ),
    );
  }

  Future<RankListResponse> _getRankList(int page) async {
    var model = await Request.getRankingList(page: page);
    if (model.errorCode == 0) {
        if (_page == 1) {
          _dataSource.clear();
        }
        _dataSource.addAll(model.data.datas);
        if (mounted) setState(() {});
    }
    return model;
  }

  void _onRefresh() async {
    _page = 1;
    await _getRankList(_page);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page = _page + 1;
    var model = await _getRankList(_page);
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    }else {
      _refreshController.loadComplete();
    }
  }

  // futureBuilder对于上下拉的还是不太好
  Widget futureBuilder() {
    return FutureBuilder(
      future: _getRankList(_page),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //请求完成
        if (snapshot.connectionState == ConnectionState.done) {
          RankListResponse model = snapshot.data;
          _dataSource.addAll(model.data.datas);
          //发生错误
          if (snapshot.hasError) {
            ToastView.show(model.errorMsg);
          }
          //请求成功，通过项目信息构建用于显示项目名称的ListView
          return _contentView(context, _dataSource);
        }
        //请求未完成时弹出loading
        return LoadingView();
      }
    );
  }
}