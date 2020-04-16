import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/DataInfo.dart';
import 'package:play_android/Responses/TopicInfo.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
//import 'package:play_android/Compose/ToastView.dart';
//import 'package:play_android/Compose/EmptyView.dart';

import 'InformationType.dart';
import 'InformationFlowListCell.dart';
import 'package:play_android/Home/BannerView.dart';

// 这个页面用于项目与公众号的列表页
class InformationFlowListView extends StatefulWidget {
  final InformationType _type;
  final TopicInfo _model;

  InformationFlowListView({Key key, @required InformationType type, @required TopicInfo model}):  
    _type = type,
    _model = model,
    super(key: key);

  @override
  _InformationFlowListViewState createState() => _InformationFlowListViewState();
}

class _InformationFlowListViewState extends State<InformationFlowListView> with  AutomaticKeepAliveClientMixin {
  List<DataInfo> _dataSource = List<DataInfo>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) => 
                  InformationFlowListCell(model: _dataSource[index],),
                itemCount: _dataSource.length,
              ),
            )
          : LoadingView(),
    );
  }

  void _onRefresh() async {
    _page = 0;
    _getList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    _getList();
    _refreshController.loadComplete();
  }

  Future<InformationFlowListResponse> _getList() async {
    var model;
    switch (widget._type) {
      case InformationType.project:
        model = await Request.getProjectClassifyList(id: widget._model.id, page: _page);
        break;
      case InformationType.publicNumber:
        model = await Request.getPubilicNumberList(id: widget._model.id, page: _page);
        break;
    }
    if (model.errorCode == 0) {
        if (_page == 1) {
          _dataSource.clear();
        }
        _dataSource.addAll(model.data.datas);
        if (mounted) setState(() {});
    }

    return model;  
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}