import 'package:flutter/material.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/ProjectClassifyResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ToastView.dart';

class ArticleView extends StatefulWidget {
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  List<Datum> _dataSource = List<Datum>();

  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //_getProjectClassify();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return futureBuilder();//_contentView();
  }

  Widget futureBuilder() {
    return FutureBuilder(
      future: _getProjectClassifyUseInFutureBuilder(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //请求完成
        if (snapshot.connectionState == ConnectionState.done) {
          ProjectClassifyResponse model = snapshot.data;
          _dataSource = model.data;
          _tabController = TabController(length: model.data.length, vsync: this);

          if (model.errorCode == 0) {
            return _mainBody();  
          }else if (model.data.isEmpty) {
            return EmptyView();
          }else {
            ToastView.show(model.errorMsg);
            return Container();
          }          
        }
        //请求未完成时弹出loading
        return LoadingView();
      }
    );
  }

  Scaffold _mainBody() {
    return Scaffold(
            appBar: AppBar(
              title: Text("项目", style: TextStyle(color: Colors.white)),
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 0.1,
              bottom: TabBar(
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
                unselectedLabelStyle:
                    TextStyle(color: Colors.grey, fontSize: 18),
                labelColor: Colors.white,
                labelPadding: EdgeInsets.all(0.0),
                indicatorPadding: EdgeInsets.all(0.0),
                indicatorWeight: 2.3,
                unselectedLabelColor: Colors.white,
              ),
            ),
            body: TabBarView(
                controller: _tabController, children: _createTabPage()),
          );
  }

  List<Widget> _createTabPage() {
    var widgets = List<Widget>() ;
    for (var model in _dataSource) {
      widgets.add(Center(child: Text(model.id.toString()),));
    }
    return widgets;
  }

  Future<ProjectClassifyResponse> _getProjectClassifyUseInFutureBuilder() async {
    var model = await Request.getProjectClassify();
    return model;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _contentView() {
    return (_dataSource.isNotEmpty && _tabController != null) ? _mainBody() : LoadingView();
  }

  // 用于initState函数中
  Future<ProjectClassifyResponse> _getProjectClassify() async {
    var model = await Request.getProjectClassify();
    if (model.errorCode == 0) {
        _dataSource = model.data;
        if (mounted) {
          setState(() {
            _tabController = TabController(length: model.data.length, vsync: this);
          });
        }   
    }
    return model;
  }
}