import 'package:flutter/material.dart';
import 'package:play_android/Responses/TopicInfo.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/DataInfo.dart';
import 'package:play_android/Responses/ProjectClassifyListResponse.dart';
import 'package:play_android/Responses/PublicNumberListResponse.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
//import 'package:play_android/Compose/EmptyView.dart';

enum InformationType {
  project,
  publicNumber
}

// 这个页面用于项目与公众号的列表页
class InformationFlowView extends StatefulWidget {
  final InformationType _type;
  final TopicInfo _model;

  InformationFlowView({Key key, @required InformationType type, @required TopicInfo model}):  
    _type = type,
    _model = model,
    super(key: key);

  @override
  _InformationFlowViewState createState() => _InformationFlowViewState();
}

class _InformationFlowViewState extends State<InformationFlowView> {
  List<DataInfo> _dataSource = List();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (c, i) =>
                    Container(child: Text(_dataSource[i].title), height: 44),
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

  Future<List<DataInfo>> _getList() async {
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

    return model.data.datas;  
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}