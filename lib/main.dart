import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VQ POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'VQ POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            var key = event.data.logicalKey.keyLabel;
            if (key == "Enter") {
              int code = int.parse(result);
              bool isValid = false;
              for (var i = 0; i <= 10; i++) {
                if (i == code) {
                  isValid = true;
                  break;
                }
              }
              print(isValid);

              if (isValid) {
                setState(() {
                  if (!qrcode[code]['isScanned']) {
                    message = "Valid QR Code!";
                    qrcode[code]['isScanned'] = true;
                  } else {
                    message = "Already Scanned! Test different one.";
                  }
                });
              } else {
                setState(() {
                  message = "Invalid QR Code!";
                });
              }
              result = "";
            } else {
              String x = key.toString();
              if (x == "0" ||
                  x == "1" ||
                  x == "2" ||
                  x == "3" ||
                  x == "4" ||
                  x == "5" ||
                  x == "6" ||
                  x == "7" ||
                  x == "7" ||
                  x == "8" ||
                  x == "9") {
                result += key.toString();
              }
            }
          } else if (event is RawKeyUpEvent) {}
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
    {"code": 0, "isScanned": false},
    {"code": 1, "isScanned": false},
    {"code": 2, "isScanned": false},
    {"code": 3, "isScanned": false},
    {"code": 4, "isScanned": false},
    {"code": 5, "isScanned": false},
    {"code": 6, "isScanned": false},
    {"code": 7, "isScanned": false},
    {"code": 8, "isScanned": false},
    {"code": 9, "isScanned": false},
    {"code": 10, "isScanned": false},
  ];

  String result = "";
  String message = "Scan QR Code";
}
