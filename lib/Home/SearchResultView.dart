import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/DataInfo.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';

import 'package:play_android/Information/InformationFlowListCell.dart';

class SearchResultView extends StatefulWidget {
  final String _keyword;

  SearchResultView({Key key, @required String keyword})
      : _keyword = keyword,
        super(key: key);

  @override
  _SearchResultViewState createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  List<DataInfo> _dataSource = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _postQueryKey(widget._keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._keyword, style: TextStyle(color: Colors.white)),
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
                itemBuilder: (context, index) => InformationFlowListCell(
                  model: _dataSource[index],
                ),
                itemCount: _dataSource.length,
              ),
            )
          : EmptyView();
  }

  void _onRefresh() async {
    _page = 0;
    _postQueryKey(widget._keyword);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    var model = await _postQueryKey(widget._keyword);
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    }else {
      _refreshController.loadComplete();
    }
  }

  Future<InformationFlowListResponse> _postQueryKey(String keyword) async {
    var model = await Request.postQueryKey(keyword: keyword, page: _page);
    if (model.errorCode == 0) {
      if (_page == 0) {
        _dataSource.clear();
      }
      _dataSource.addAll(model.data.datas);
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
