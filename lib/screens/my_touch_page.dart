import 'dart:async';
import 'package:flutter/material.dart';
import 'second_page.dart';

class MyTouchPage extends StatefulWidget {
  const MyTouchPage({super.key});

  @override
  _MyTouchPageState createState() => _MyTouchPageState();
}

class _MyTouchPageState extends State<MyTouchPage> {
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 8), () {
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
    return Scaffold(
      backgroundColor: const Color(0xFF247BA0),
      body: GestureDetector(
        onTap: _navigateToSecondPage,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
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
}
