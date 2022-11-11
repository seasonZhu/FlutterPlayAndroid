import 'package:flutter/material.dart';

class DismissibleView extends StatelessWidget {
  final List<String> items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dismission Items", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: Key(item),
            // 需要提示滑动方法,默认是水平,左滑右滑都可以
            direction: DismissDirection.endToStart,
            // We also need to provide a function that will tell our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              items.removeAt(index);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away
            background: Container(color: Theme.of(context).primaryColor),
            child: ListTile(title: Text('$item')),
          );
        },
      ),
    );
  }
}