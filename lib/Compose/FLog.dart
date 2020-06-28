import 'package:stack_trace/stack_trace.dart';
// stack_trace 在 Flutter 环境下直接导包即可使用，而在纯 Dart 下需要将其添加为依赖于pubspec.yaml中

enum FLogMode {
  debug, // 💚 DEBUG
  warning, // 💛 WARNING
  info, // 💙 INFO
  error, // ❤️ ERROR
}

/// Dart中的枚举只能在扩展中进行函数扩展,不能在枚举定义中进行
extension Property on FLogMode {
  String get description {
    var string;

    switch (this) {
      case FLogMode.debug:
        string = "💚 DEBUG";
        break;
      case FLogMode.warning:
        string = "💛 WARNING";
        break;
      case FLogMode.info:
        string = "💙 INFO";
        break;
      case FLogMode.error:
        string = "❤️ ERROR";
        break;
    }
    return string;
  }
}

bool _inProduction = const bool.fromEnvironment("dart.vm.product");

void fLog(dynamic msg, {FLogMode mode = FLogMode.debug}) {
  if (_inProduction) {
    // release模式不打印
    return;
  }
  var chain = Chain.current(); // Chain.forTrace(StackTrace.current);
  // 将 core 和 flutter 包的堆栈合起来（即相关数据只剩其中一条）
  chain =
      chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");
  // 取出所有信息帧
  final frames = chain.toTrace().frames;
  // 找到当前函数的信息帧 字符串"fLog"要与函数名称对应
  final idx = frames.indexWhere((element) => element.member == "fLog");
  if (idx == -1 || idx + 1 >= frames.length) {
    return;
  }
  // 调用当前函数的函数信息帧
  final frame = frames[idx + 1];

  print("${mode.description} ${frame.uri.toString().split("/").last}(${frame.line}) - $msg ");
}
