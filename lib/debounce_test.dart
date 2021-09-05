import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';

class Debounce extends StatelessWidget {
  const Debounce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debounce Test"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            EasyDebounce.debounce('debouncer1', Duration(milliseconds: 2000),
                () => {print("hi")});
          },
          child: null,
        ),
      ),
    );
  }
}
