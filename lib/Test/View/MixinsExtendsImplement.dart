import 'package:flutter/material.dart';

/// 对mixin的一点实践与思考
mixin CanFly {
  void fly();
}

class Bird with CanFly {
  @override
  void fly() {
    print("鸟儿飞呀飞");
  }
}

class Me with CanFly {
  @override
  void fly() {
    print("我的梦飞呀飞");
  }
}

class Some extends StatefulWidget {
  @override
  _SomeState createState() => _SomeState();
}

class _SomeState extends State<Some> {
  @override
  Widget build(BuildContext context) {
    List<CanFly> some = []..add(Me())..add(Bird());
    some.map((s) => s.fly());

    return Container();
  }

  /// 只能抽象的泛型使用,不能T with CanFly,不过CanFly其实已经可以认为是一种类型接口类型了
  Future<CanFly> someFunction() async {
    var s = await Bird(); // Me() 都是可以的
    return s;
  }
}

class User {
  final String name;

  ///初始化方法
  User(this.name);

  ///工厂方法
  factory User.season() {
    return User("season");
  }

  ///静态方法
  static User some() {
    return User("some");
  }
}

var season = User.season();
var some = User.some();
var user = User("haha");

class Cat {
  void show() {
    print("小猫");
  }
}

class Duck {
  void show() {
    print("小鸭");
  }
}

class Owner {
  void show() {
    print("主人");
  }
}

class Person1 extends Owner with Cat, Duck {
  // void show() {
  //   print("主人样了猫和鸭");
  // }
}

/// 放开注解,最先执行本类中的方法,注解之后,执行优先顺序是mixins->extends->implements
class Person2 extends Owner with Cat implements Duck {
  // void show() {
  //   print("主人样了猫和鸭");
  // }
}
