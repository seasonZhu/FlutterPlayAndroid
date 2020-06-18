import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/InformationFlowTopicResponse.dart';
import 'package:play_android/Responses/TopicInfo.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';

import 'TreeCell.dart';

class TreeView extends StatefulWidget {
  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> with AutomaticKeepAliveClientMixin {
  List<TopicInfo> _dataSource = List<TopicInfo>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTree();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("体系", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) => TreeCell(_dataSource[index]),
                itemCount: _dataSource.length,
              ),
            )
          : LoadingView(),
    );
  }


  void _onRefresh() async {
    await _getTree();
    _refreshController.refreshCompleted();
  }

  Future<InformationFlowTopicResponse> _getTree() async {
    var model = await Request.getTree();
    if (model.errorCode == 0) {
      _dataSource.clear();
      _dataSource.addAll(model.data);
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