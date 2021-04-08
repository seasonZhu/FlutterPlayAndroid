import 'dart:async';

import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

typedef ObserverBuilder<T> = Widget Function(BuildContext context, T data);

class SingleDataLine<T> {
  StreamController<T> _stream;

  //拿到当前最新的数据
  T currentData;

  SingleDataLine([T initData]) {
    currentData = initData;
    _stream = initData == null
        ? BehaviorSubject<T>()
        : BehaviorSubject<T>.seeded(initData);
  }

  get outer => _stream.stream;

  get inner => _stream.sink;

  void setData(T t) {
    //同值过滤
    if (t == currentData) return;
    //防止关闭
    if (_stream.isClosed) return;
    currentData = t;
    inner.add(t);
  }

  Widget addObserver(ObserverBuilder<T> observer) {
    return DataObserverWidget<T>(this, observer);
  }

  void dispose() {
    inner.close();
    _stream.close();
  }
}

class DataObserverWidget<T> extends StatefulWidget {
  final SingleDataLine<T> _dataLine;

  final ObserverBuilder<T> _builder;

  DataObserverWidget(this._dataLine, this._builder);

  @override
  _DataObserverWidgetState<T> createState() => _DataObserverWidgetState<T>();
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._dataLine.outer,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot != null && snapshot.data != null) {
          print(
              " ${context.widget.toString()} 中的steam接收到了一次数据${snapshot.data}");
          return widget._builder(context, snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    widget._dataLine.dispose();
    super.dispose();
  }
}

mixin MultDataLine {
  final Map<String, SingleDataLine> dataBus = Map();

  SingleDataLine<T> getLine<T>(String key) {
    if (!dataBus.containsKey(key)) {
      SingleDataLine<T> dataLine = SingleDataLine<T>();
      dataBus[key] = dataLine;
    }
    return dataBus[key];
  }

  void dispose() {
    dataBus.values.forEach((f) => f.dispose());
    dataBus.clear();
  }
}
