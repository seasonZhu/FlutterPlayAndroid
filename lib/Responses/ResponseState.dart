/* 
Dart的枚举功能还不够强大,居然不能进行嵌套使用
Dart的枚举不能有默认的继承Int或者String等基本类型,不过还是可以用分类做点处理
对于一个UI = f(state)的框架,枚举真的很重要
和Swift的枚举比真的太弱鸡了
 */

enum ResponseState {
  success,
  loading,
  fail
}

extension Value on ResponseState {
  get value {
    switch (this) {
      case ResponseState.success:
        return 200;
      case ResponseState.loading:
        return 0;
      case ResponseState.fail:
        return 1;
    }
  }
}

enum ResponseSuccessState {
  hasContent,
  empty
}

extension SuccessValue on ResponseSuccessState {
  get value {
    switch (this) {
      case ResponseSuccessState.hasContent:
        return 2;
      case ResponseSuccessState.empty:
        return 3;
    }
  }
}