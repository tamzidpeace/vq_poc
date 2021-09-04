import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  initState() {
    super.initState();

    _keyboardListenerFocus.addListener(() {
      setState(() => _listenerActive = _keyboardListenerFocus.hasFocus);
    });

    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

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

  final _keyboardListenerFocus = FocusNode();
  String _keyName = 'N/A';
  bool _listenerActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Plain TextField:'),
            Container(width: 200, child: TextField()),
            SizedBox(height: 50),
            Text('Tap the green container to focus the RawKeyboardListener:'),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () => _keyboardListenerFocus.requestFocus(),
              child: Container(
                width: 200,
                height: 100,
                color: _listenerActive ? Colors.lightGreen : Colors.green,
                alignment: Alignment.center,
                child: RawKeyboardListener(
                  focusNode: _keyboardListenerFocus,
                  onKey: (keyEvent) {
                    setState(
                        () => _keyName = keyEvent.data.logicalKey.debugName!);
                    //showToast(_keyName.toString());
                    showToast(keyEvent.data.logicalKey.keyLabel.toString());
                  },
                  child: _listenerActive
                      ? Text(
                          'Listener focused!\nPress some keys.\nkeyName = $_keyName',
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Listener not focused\nTap here to focus\n',
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showInput() {}
}
