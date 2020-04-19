import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/MyCollectResponse.dart';
import 'package:play_android/Responses/CollectArticleActionResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';

import 'MyCollectViewCell.dart';

class MyCollectView extends StatefulWidget {
  @override
  _MyCollectViewState createState() => _MyCollectViewState();
}

class _MyCollectViewState extends State<MyCollectView> {
  List<DataElement> _dataSource = List<DataElement>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  SlidableController _slidableController = SlidableController();
  int _page = 0;
  bool _isRequestFinish = false;

  @override
  void initState() {
    super.initState();
    _getCollectArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的收藏", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
        ),
        body: _body());
  }

  Widget _body() {
    return SafeArea(
      child:
          Container(child: _isRequestFinish ? _contentView() : LoadingView()),
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
              itemBuilder: (context, index) => _sideslipCell(index),
              itemCount: _dataSource.length,
            ),
          )
        : EmptyView();
  }

  Widget _sideslipCell(int index) {
    return Slidable(
      key: Key(_dataSource[index].title),
      controller: _slidableController,
      child: MyCollectViewCell(
        model: _dataSource[index],
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: IconSlideAction(
            caption: '取消收藏',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _unCollectAction(index);
            },
          ),
        ),
      ]
    );
  }

  void _onRefresh() async {
    _page = 0;
    _getCollectArticleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    var model = await _getCollectArticleList();
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  Future<MyCollectResponse> _getCollectArticleList() async {
    var model = await Request.getCollectArticleList(page: _page);
    _isRequestFinish = true;
    if (model.errorCode == 0) {
      if (_page == 0) {
        _dataSource.clear();
      }
      _dataSource.addAll(model.data.datas);
      if (_dataSource.length < model.data.size) {
        _refreshController.loadNoData();
      }
      if (mounted) setState(() {});
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  Future<CollectArticleActionResponse> _unCollectAction(int index) async {
    var model = await Request.collectAction(id: _dataSource[index].originId, isCollect: false);
    if (model.errorCode == 0) {
      _dataSource.removeAt(index);
      ToastView.show("取消收藏成功");
      if (mounted) setState(() {});
    } else {
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