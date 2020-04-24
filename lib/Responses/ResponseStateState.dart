// Dart的枚举功能还不够强大,居然不能进行嵌套使用
// 对于一个UI = f(state)的框架,枚举真的很重要
// 和Swift的枚举比真的太弱鸡了

enum ResponseState {
  success,
  loading,
  fail
}

enum ResponseSuccessState {
  hasContent,
  empty
}