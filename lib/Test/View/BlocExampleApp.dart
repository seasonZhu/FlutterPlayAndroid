import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   runApp(BlocExampleApp());
// }

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class BlocExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: BlocProvider(
              create: (_) => CounterBloc(),
              child: CounterPage(),
            ),
            theme: theme,
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterBloc, int>(
        builder: (_, count) {
          return Center(
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      /// 这里报了一个错: There are multiple heroes that share the same tag within a subtree,
      /// 因为我的漂浮button其实一个FloatingActionButton的列表,但是创建FloatingActionButton使用的默认的heroTag,于是报错了
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "add",
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "decrement",
              child: const Icon(Icons.remove),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.decrement),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "themeEvent",
              child: const Icon(Icons.brightness_6),
              onPressed: () => context.bloc<ThemeBloc>().add(ThemeEvent.toggle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "error",
              backgroundColor: Colors.red,
              child: const Icon(Icons.error),
              onPressed: () => context.bloc<CounterBloc>().add(CounterEvent.error),
            ),
          ),
        ],
      ),
    );
  }
}

enum CounterEvent { increment, decrement, error }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.error:
        yield state;
        break;
      default:
        throw Exception('oops');
    }
  }
}

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => ThemeData.light();

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield state == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
        break;
    }
  }
}
