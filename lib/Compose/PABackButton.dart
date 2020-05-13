import 'package:flutter/material.dart';

// 说实话,我不知道这个按钮有什么用
class PABackButton extends StatelessWidget {
  const PABackButton({Key key, this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
        icon: Icon(Icons.arrow_back),
        color: color,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          Navigator.maybePop(context);
        });
  }
}