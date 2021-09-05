import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NormalMode extends StatefulWidget {
  NormalMode({Key? key}) : super(key: key);

  @override
  _NormalModeState createState() => _NormalModeState();
}

class _NormalModeState extends State<NormalMode> {
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
      appBar: AppBar(
        title: Text("VQ POC Normal Mode"),
        centerTitle: true,
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) async {
          if (event is RawKeyDownEvent) {
            var key = event.data.logicalKey.keyLabel;

            result += key.toString();
            EasyDebounce.debounce('debouncer1', Duration(milliseconds: 2000),
                () {
              operation();
            });
            showToast(key.toString());
          } /* else if (event is RawKeyUpEvent) {} */
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "$message",
                      style: TextStyle(fontSize: 30),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: ListView.builder(
                        itemCount: qrcode.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  qrcode[index]['isScanned']
                                      ? "Scanned"
                                      : '${qrcode[index]['code']}',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* functionalities
  @override
  void initState() {
    super.initState();
  }

  List qrcode = [
    {"code": 'a', "isScanned": false},
    {"code": 'b', "isScanned": false},
    {"code": 'c', "isScanned": false},
    {"code": 'd', "isScanned": false},
    {"code": 'e', "isScanned": false},
    {"code": 'f', "isScanned": false},
    {"code": 'g', "isScanned": false},
    {"code": 'h', "isScanned": false},
    {"code": 'i', "isScanned": false},
    {"code": 'j', "isScanned": false},
    {"code": 'k', "isScanned": false},
  ];

  String result = "";
  String message = "Scan QR Code";

  Future<void> operation() async {
    bool isValid = false;
    int position = 0;
    String code = result;
    for (var i = 0; i < qrcode.length; i++) {
      if (code.toLowerCase() == qrcode[i]['code']) {
        isValid = true;
        position = i;
        break;
      }
    }

    if (isValid) {
      setState(() {
        if (!qrcode[position]['isScanned']) {
          message = "Valid QR Code!";
          qrcode[position]['isScanned'] = true;
        } else {
          message = "Already Scanned! Test different one.";
        }
      });
      Future.delayed(
          Duration(
            seconds: 5,
          ), () {
        setState(() {
          message = "Scan Again!";
        });
        print(message);
      });
    } else {
      setState(() {
        message = "Invalid QR Code!";
      });
      Future.delayed(
          Duration(
            seconds: 5,
          ), () {
        setState(() {
          message = "Scan Again!";
        });
        print(message);
      });
    }

    showToast(result);
    result = "";
  }
}
