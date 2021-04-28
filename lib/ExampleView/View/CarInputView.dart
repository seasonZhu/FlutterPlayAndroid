/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:cool_ui/cool_ui.dart';

import 'TestKeyboard.dart';

class CarInputView extends StatefulWidget {
  CarInputView({Key key}) : super(key: key);

  @override
  _CarInputViewState createState() => _CarInputViewState();
}

class _CarInputViewState extends State<CarInputView> {
  TextEditingController controller = TextEditingController();
  List dataList = ['', '', '', '', '', ''];

  Widget renderContainer(title) {
    return Container(
      width: 60,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: title == '' ? Colors.green : Colors.blue, width: 2),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.blue),
      ),
    );
  }

  List fillData(List data) {
    if (data.length < 6) {
      data.add('');
      fillData(data);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: Builder(
        builder: (cxt) {
          return Scaffold(
            appBar: AppBar(
              title: Text("车牌号输入"),
            ),
            body: GestureDetector(
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: dataList
                              .map<Widget>((e) => renderContainer(e))
                              .toList(),
                        ),
                        TextField(
                          maxLength: 6,
                          onChanged: (value) {
                            List data = [];
                            for (int i = 0; i < value.length; i++) {
                              data.add(value.substring(i, i + 1));
                            }
                            data = fillData(data);
                            if (mounted) {
                              setState(() {
                                dataList = data;
                              });
                            }
                          },
                          controller: controller,
                          cursorWidth: 0,
                          cursorColor: Colors.transparent,
                          keyboardType: TestKeyboard.inputType,
                          style: TextStyle(color: Colors.transparent),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/