import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

/// 这个页面有点异常
class UpdateView extends StatefulWidget {
  @override
  _UpdateViewState createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  Map mockData = {
      'isForceUpdate': false,// 是否强制更新
      'content': '这是更新的内容',
      'url': 'http://www.flutterj.com/test.apk',// 安装包的链接
  };

  @override
  void initState() {
    super.initState();
    updateAlert(context, mockData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App更新')),
      body: Container(),
    );
  }
}

const mainTextColor = Color.fromRGBO(115, 115, 115, 1.0);

Future<void> updateAlert(BuildContext context, Map data) async {
  bool isForceUpdate = data['isForceUpdate']; // 从数据拿到是否强制更新字段

  Future.delayed(Duration(seconds: 2)).then((value) {
    showDialog(
      // 显示对话框
      context: context,
      barrierDismissible: false, // 点击空白区域不结束对话框
      builder: (_) => WillPopScope(
        // 拦截返回键
        child: UpgradeDialog(data, isForceUpdate, updateUrl: data['url']),
        // 有状态类对话框
        onWillPop: () {
          return; // 检测到返回键直接返回
        },
      ),
    );
  });
}

class UpgradeDialog extends StatefulWidget {
  final Map data; // 数据
  final bool isForceUpdate; // 是否强制更新
  final String updateUrl; // 更新的url（安装包下载地址）

  UpgradeDialog(this.data, this.isForceUpdate, {this.updateUrl});

  @override
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  int _downloadProgress = 0; // 进度初始化为0

  CancelToken token;
  UploadingFlag uploadingFlag = UploadingFlag.idle;

  @override
  void initState() {
    super.initState();
    token = CancelToken(); // token初始化
  }

  @override
  Widget build(BuildContext context) {
    String info = widget.data['content']; // 更新内容

    return Center(
      // 剧中组件
      child: Material(
        type: MaterialType.transparency,
        textStyle: TextStyle(color: const Color(0xFF212121)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 宽度是整宽的百分之80
          decoration: BoxDecoration(
            color: Colors.white, // 背景白色
            borderRadius: BorderRadius.all(Radius.circular(4.0)), // 圆角
          ),
          child: Wrap(
            children: <Widget>[
              SizedBox(height: 10.0, width: 10.0),
              Align(
                alignment: Alignment.topRight,
                child: widget.isForceUpdate
                    ? Container()
                    : InkWell(
                        // 不强制更新才显示这个
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                            right: 15.0,
                            bottom: 5.0,
                            left: 5.0,
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () => Navigator.of(context).pop(),
                      ),
              ),
              Center(
                child: Image.asset('assets/images/saber.jpg',
                    width: 121.5, fit: BoxFit.cover),
              ),
              /// Wrap控件一般都是用于横向排列,当位置不够时会自动换行,
              /// 通过将Container的width使用double.infinity,基本上可以看成是Column使用,在需要一行多个控件的时候进行配置即可
              Container(
                height: 30.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text('升级到最新版本',
                    style: TextStyle(
                        color: const Color(0xff343243),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    child: Text('$info',
                        style: TextStyle(color: Color(0xff7A7A7A)))),
              ),
              getLoadingWidget(),
              Container(
                height: 80.0,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0)),
                ),
                child: MaterialButton(
                  child: Text('立即升级'),
                  onPressed: () => upgradeHandle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * Android更新处理
  * */
  void _androidUpdate() async {
    final apkPath = await FileUtil.getInstance().getSavePath("/Download/");
    try {
      await Dio().download(
        widget.updateUrl,
        apkPath + "test.apk",
        cancelToken: token,
        onReceiveProgress: (int count, int total) {
          if (mounted) {
            setState(() {
              _downloadProgress = ((count / total) * 100).toInt();
              if (_downloadProgress == 100) {
                if (mounted) {
                  setState(() {
                    uploadingFlag = UploadingFlag.uploaded;
                  });
                }
                debugPrint("读取的目录:$apkPath");
                try {
                  OpenFile.open(apkPath + "test.apk");
                } catch (e) {}
                Navigator.of(context).pop();
              }
            });
          }
        },
        options: Options(sendTimeout: 15 * 1000, receiveTimeout: 360 * 1000),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          uploadingFlag = UploadingFlag.uploadingFailed;
        });
      }
    }
  }

  /*
  * 进度显示的组件
  * */
  Widget getLoadingWidget() {
    if (_downloadProgress != 0 && uploadingFlag == UploadingFlag.uploading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        width: double.infinity,
        height: 40,
        alignment: Alignment.center,
        child: LinearProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          backgroundColor: Colors.grey[300],
          value: _downloadProgress / 100,
        ),
      );
    }

    /*
    * 如果是在进行中并且进度为0则显示
    * */
    if (uploadingFlag == UploadingFlag.uploading && _downloadProgress == 0) {
      return Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(mainTextColor)),
            SizedBox(width: 5),
            Material(
              child: Text(
                '等待',
                style: TextStyle(color: mainTextColor),
              ),
              color: Colors.transparent,
            )
          ],
        ),
      );
    }

    /*
    * 如果下载失败则显示
    * */
    if (uploadingFlag == UploadingFlag.uploadingFailed) {
      return Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.clear, color: Colors.redAccent),
            SizedBox(width: 5),
            Material(
              child: Text(
                '下载超时',
                style: TextStyle(color: mainTextColor),
              ),
              color: Colors.transparent,
            )
          ],
        ),
      );
    }
    return Container();
  }

  /*
  * IOS更新处理，直接打开AppStore链接
  * */
  void _iosUpdate() {
    launch(widget.updateUrl);
  }

  /*
  * 更新处理事件
  * */
  upgradeHandle() {
    if (uploadingFlag == UploadingFlag.uploading) return;
    uploadingFlag = UploadingFlag.uploading;
    // 必须保证当前状态安全，才能进行状态刷新
    if (mounted) setState(() {});
    // 进行平台判断
    if (Platform.isAndroid) {
      _androidUpdate();
    } else if (Platform.isIOS) {
      _iosUpdate();
    }
  }

  ///跳转本地浏览器
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    if (!token.isCancelled) token?.cancel();
    super.dispose();
    debugPrint("升级销毁");
  }
}

enum UploadingFlag { 
  uploading, 
  idle, 
  uploaded, 
  uploadingFailed 
}

// 文件工具类
class FileUtil {
  static FileUtil _instance;

  static FileUtil getInstance() {
    if (_instance == null) {
      _instance = FileUtil._internal();
    }
    return _instance;
  }

  FileUtil._internal();

  /*
  * 保存路径
  * */
  Future<String> getSavePath(String endPath) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path = tempDir.path + endPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return path;
  }
}