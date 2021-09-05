import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vq_poc/enter_mode.dart';
import 'package:vq_poc/normal_mode.dart';

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
        msg: "Hello",
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
      appBar: AppBar(
        title: Text("VQ POC"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Tap the green container to focus the RawKeyboardListener. Now scan any qr code or connect a keyboard to test keyboard event. If toast message print "Enter", then your qr reader press an "Enter" after each sacn. So you can test with enter mode. but if it does not print "Enter", that means your qr scanner does not press "Enter" after qr code scan. So you have to test with normal mode. You can add "Enter" for each scan from you qr scanner user manual.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
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
                          'Listener focused!\nPress some keys or sacn qr code.\nkeyName = $_keyName',
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Listener not focused\nTap here to focus\n',
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterMode(title: 'Enter Mode'),
                        ),
                      );
                    },
                    child: Text(
                      "Test Enter Mode",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NormalMode(),
                        ),
                      );
                    },
                    child: Text(
                      "Test Normal Mode",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showInput() {}
}
