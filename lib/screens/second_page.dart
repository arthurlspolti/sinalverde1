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
    _playAudio('toque.mp3');
  }

  Future<void> _playAudio(String assetPath) async {
    await _audioPlayer.stop(); // Para parar a reprodução anterior
    await _audioPlayer.play(AssetSource(assetPath));
    await _audioPlayer.setVolume(1);
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _circleColor = Colors.red;
        _playAudio('sinalvermelho.mp3'); // Parar a reprodução do áudio quando o semáforo fica vermelho
      });
    });
  }

  void _simulateArduinoSignal() {
    setState(() {
      _circleColor = Colors.green;
      _playAudio('sinalverde.mp3'); // Reproduzir áudio de sinal verde
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
