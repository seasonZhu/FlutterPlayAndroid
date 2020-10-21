import 'package:flutter/material.dart';

import 'package:play_android/Responses/TopicInfo.dart';
import 'package:play_android/Responses/InformationFlowTopicResponse.dart';

import 'package:play_android/Information/InformationType.dart';
import 'package:play_android/Information/InformationFlowListView.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ToastView.dart';

class InformationFlowTopicView extends StatefulWidget {
  final InformationType _type;

  InformationFlowTopicView({Key key, @required InformationType type})
      : _type = type,
        super(key: key);

  @override
  _InformationFlowTopicViewState createState() =>
      _InformationFlowTopicViewState();
}

class _InformationFlowTopicViewState extends State<InformationFlowTopicView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<TopicInfo> _dataSource = [];

  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTopic();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _contentView(); //futureBuilder()
  }

  Widget futureBuilder() {
    return FutureBuilder(
        future: _getTopicUseInFutureBuilder(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            InformationFlowTopicResponse model = snapshot.data;
            _dataSource = model.data;
            _tabController =
                TabController(length: model.data.length, vsync: this);

            if (model.errorCode == 0) {
              return _mainBody();
            } else if (model.data.isEmpty) {
              return EmptyView();
            } else {
              ToastView.show(model.errorMsg);
              return Container();
            }
          }
          //请求未完成时弹出loading
          return _loadingBody();
        });
  }

  Scaffold _mainBody() {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget._type.title, style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
          bottom: tabBar()),
      body: TabBarView(controller: _tabController, children: _createTabPage()),
    );
  }

  Scaffold _loadingBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._type.title, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Container(),
    );
  }

  TabBar tabBar() {
    return TabBar(
      tabs: _dataSource.map((model) {
        return Tab(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(model.name),
          ),
        );
      }).toList(),
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
      unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 18),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.all(0.0),
      indicatorPadding: EdgeInsets.all(0.0),
      indicatorWeight: 2.3,
      unselectedLabelColor: Colors.white,
    );
  }

  List<Widget> _createTabPage() {
    return _dataSource
        .map((model) => InformationFlowListView(
              model: model,
              type: InformationType.publicNumber,
            ))
        .toList();
  }

  Future<InformationFlowTopicResponse> _getTopicUseInFutureBuilder() async {
    var model = await widget._type.model;
    return model;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _contentView() {
    return (_dataSource.isNotEmpty && _tabController != null)
        ? _mainBody()
        : _loadingBody();
  }

  // 用于initState函数中
  Future<InformationFlowTopicResponse> _getTopic() async {
    var model = await widget._type.model;

    if (model.errorCode == 0) {
      _dataSource = model.data;
      if (mounted) {
        setState(() {
          _tabController =
              TabController(length: model.data.length, vsync: this);
        });
      }
    }
    return model;
  }
}
