import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/InformationFlowTopicResponse.dart';

enum InformationType {
  project,
  publicNumber
}

// 分类继续使用
extension Property on InformationType {
  String get title {
    var title;
    switch (this) {
      case InformationType.project:
        title = "项目";
        break;
      case InformationType.publicNumber:
        title = "公众号";
        break;
    }
    return title;
  }

  Future<InformationFlowTopicResponse> get model async {
    var model;
    switch (this) {
      case InformationType.project:
        model = await Request.getProjectClassify();
        break;
      case InformationType.publicNumber:
        model = await Request.getPubilicNumber();
        break;
    }
    return model;
  }
}