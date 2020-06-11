import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/MyCoinResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';

import 'MyCoinViewCell.dart';

class MyCoinView extends StatefulWidget {
  @override
  _MyCoinViewState createState() => _MyCoinViewState();
}

class _MyCoinViewState extends State<MyCoinView> {
  List<DataElement> _dataSource = List<DataElement>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getCoinList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的积分", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
        ),
        body: _body());
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        child: _dataSource.length > 0 ? _contentView() : LoadingView()
      ),
    );
  }

  Widget _contentView() {
    return _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) => MyCoinViewCell(
                  model: _dataSource[index],
                ),
                itemCount: _dataSource.length,
              ),
            )
          : EmptyView();
  }

  void _onRefresh() async {
    _page = 0;
    _getCoinList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    var model = await _getCoinList();
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    }else {
      _refreshController.loadComplete();
    }
  }

  Future<MyCoinResponse> _getCoinList() async {
    var model = await Request.getCoinList(page: _page);
    if (model.errorCode == 0) {
      if (_page == 0) {
        _dataSource.clear();
      }
      _dataSource.addAll(model.data.datas);
      if (_dataSource.length < model.data.size) {
        _refreshController.loadNoData();
      } 
      if (mounted) setState(() {});
    }else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}