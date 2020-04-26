import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/View/Routes.dart';
import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/DataInfo.dart';
import 'package:play_android/Responses/ArticleTopListResponse.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
//import 'package:play_android/Compose/EmptyView.dart';

import 'package:play_android/Information/InformationFlowListCell.dart';
import 'BannerView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<DataInfo> _dataSource = List<DataInfo>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController = ScrollController();

  int _page = 0;

  double _offset = 0;

  @override
  void initState() {
    super.initState();

    // 监听滑动的offset
    _scrollController.addListener(() {
      _offset = _scrollController.offset;
      print("offset: ${_scrollController.offset}");
    });

    _getTopArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _pushToHotkeView(context);
              })
        ],
      ),
      body: _body(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _body() {
    return Container(
      child: _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    _sectionHeader(index),
                    InformationFlowListCell(
                      model: _dataSource[index],
                    ),
                  ],
                ),
                itemCount: _dataSource.length,
              ),
            )
          : LoadingView(),
    );
  }

  Widget _sectionHeader(int index) {
    if (index == 0) {
      return BannerView();
    }
    return Container();
  }

  // 由于Flutter的使用会使得iOS中点击statusBar滑动到顶部的方案失效,这个floatButton不思维一直解决方法
  Widget _buildFloatingActionButton() {
    if (_offset <= 120) {
      return Container();
    }

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.keyboard_arrow_up,
      ),
      onPressed: () {
        _scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    );
  }

  void _onRefresh() async {
    _page = 0;
    _getTopArticleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    var model = await _getArticleList();
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  Future<ArticleTopListResponse> _getTopArticleList() async {
    var model = await Request.getTopArticleList();
    if (model.errorCode == 0) {
      _dataSource.clear();
      _dataSource.addAll(model.data);
      if (mounted) setState(() {});
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  Future<InformationFlowListResponse> _getArticleList() async {
    var model = await Request.getArticleList(page: _page - 1);
    if (model.errorCode == 0) {
      _dataSource.addAll(model.data.datas);
      if (mounted) setState(() {});
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  void _pushToHotkeView(BuildContext context) {
    Navigator.pushNamed(context, Routes.hotKeyView);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
