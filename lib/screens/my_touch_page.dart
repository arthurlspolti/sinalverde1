import 'dart:async';
import 'package:flutter/material.dart';
import 'second_page.dart';
import 'package:flutter/services.dart';

class MyTouchPage extends StatefulWidget {
  @override
  _MyTouchPageState createState() => _MyTouchPageState();
}

class _MyTouchPageState extends State<MyTouchPage> {
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 17), () {
      setState(() {
        _isButtonEnabled = true;
      });
    });
  }

  void _navigateToSecondPage() {
    if (_isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detect the current device orientation
    final Orientation orientation = MediaQuery.of(context).orientation;

    // Lock the screen orientation to portrait or landscape as needed
    SystemChrome.setPreferredOrientations([
      orientation == Orientation.portrait
          ? DeviceOrientation.portraitUp
          : DeviceOrientation.landscapeLeft,
    ]);

    return Scaffold(
      backgroundColor: Color(0xFF247BA0),
      body: GestureDetector(
        onTap: _navigateToSecondPage,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/arrow.png"),
                      fit: BoxFit.contain,
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

  @override
  void dispose() {
    // Reset the preferred screen orientations when disposing the widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
