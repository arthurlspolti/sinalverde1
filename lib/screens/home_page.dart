import 'package:flutter/material.dart';
import '../widgets/audio_button.dart';
import 'my_touch_page.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyTouchPage()),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFF247BA0),
        appBar: AppBar(
          backgroundColor: Color(0xFF13293D),
          automaticallyImplyLeading: false,
          title: Text(
            'Sinal verde',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Center(
            child: AudioButton(),
          ),
        ),
      ),
    );
  }
}
