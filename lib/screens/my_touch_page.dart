import 'package:flutter/material.dart';
import 'second_page.dart';

class MyTouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFF247BA0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
