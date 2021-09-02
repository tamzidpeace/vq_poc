
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  initState() {
    super.initState();
  }

  String message = "";

  int i = 0;

  void showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          i++;
          // if (i % 3 == 0) print(event.data.logicalKey);
          setState(() {
            if (i % 3 == 0) {
              message += event.data.logicalKey.keyLabel;
            }
          });
          if (event.data.logicalKey.keyLabel == "Enter") {
            print(event.data.logicalKey.keyLabel);

            showToast(message.substring(0, (message.length - 5)));
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                message = "";
              });
            });
          }
        },
        child: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
