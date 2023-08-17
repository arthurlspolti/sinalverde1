import 'dart:async';

import 'package:flutter/material.dart';
import 'second_page.dart';

class MyTouchPage extends StatefulWidget {
  @override
  _MyTouchPageState createState() => _MyTouchPageState();
}

class _MyTouchPageState extends State<MyTouchPage> {
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 7), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF247BA0),
      body: Center(
        child: GestureDetector(
          onTap: _isButtonDisabled
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
          child: Semantics(
            label: "Avançar para a próxima página",
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 120000,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
