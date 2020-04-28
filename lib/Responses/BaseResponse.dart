import 'ResponseState.dart';

/* 思考如果通过协议进行泛型化 */
abstract class BaseResponse<T> {
  T data;
  int errorCode;
  String errorMsg;

  ResponseState get responseState => _responseState;

  ResponseSuccessState get successState => _successState;
}

// 这种匿名分类只能在该文件内进行使用,如果去import该文件,是找不到这个方法的,对外可用的分类必须取名
extension on BaseResponse {
  ResponseState get _responseState {
    if (errorCode == null) {
      return ResponseState.loading;
    }else if (errorCode == 0) {
      return ResponseState.success;
    }else {
      return ResponseState.fail;
    }
  }

  ResponseSuccessState get _successState {
      if (data is List) {
        var listData = data as List;
        if (listData.length > 0) {
          return ResponseSuccessState.hasContent;
        }else {
          return ResponseSuccessState.empty;
        }
      } else if (data is BaseResponseData) {
        var baseResponseData = data as BaseResponseData;
        if (baseResponseData.datas.length > 0) {
          return ResponseSuccessState.hasContent;
        }else {
          return ResponseSuccessState.empty;
        }
      } else {
        if (data != null) {
          return ResponseSuccessState.hasContent;
        }else {
          return ResponseSuccessState.empty;
        }
      }
    }
}

// BaseResponse的T类型中包裹着List<T>的datas属性
abstract class BaseResponseData<T> {
  List<T> datas;
}