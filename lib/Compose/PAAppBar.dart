import 'package:flutter/material.dart';

/// 编写了一个类似iOS的普普通通的导航栏
class PAAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final Widget titleView;

  final Widget leading;

  final List<Widget> actions;

  final Color color;

  const PAAppBar({Key key, this.leading, this.titleView, this.title, this.actions, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: titleView ?? Text(
        title ?? "",
        style: TextStyle(color: color ?? Colors.white),
      ),
      iconTheme: IconThemeData(color: color ?? Colors.white),
      actions: actions,
      elevation: 0.1,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
