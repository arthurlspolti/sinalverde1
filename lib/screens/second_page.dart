import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  Color _circleColor = Colors.green;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('toque.mp3'));
    await _audioPlayer.setVolume(1);
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _circleColor = Colors.red;
      });
    });
  }

  void _simulateArduinoSignal() {
    setState(() {
      _circleColor = Colors.green;
      _startTimer();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF247BA0),
      appBar: AppBar(
        backgroundColor: Color(0xFF13293D),
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: _circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _circleColor == Colors.green ? 'Avançar' : 'Parar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'verdana',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _simulateArduinoSignal();
                },
                child: Text('Simular Sinal Arduino'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SecondPage()));
}
