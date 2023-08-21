import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;

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
    _initWifi();
  }

  String semaforoStatus = 'Carregando...';

  Future<void> fetchSemaforoStatus() async {
    final response = await http.get(Uri.parse('http://192.168.4.1/status'));

    if (response.statusCode == 200) {
      setState(() {
         _circleColor = Colors.red;
        _playAudio('sinalvermelho.mp3');
      });
    } else if (response.statusCode == 100) {
      setState(() {
        _circleColor = Colors.green;
        _playAudio('sinalverde.mp3');
      });
    }
  }

  Future<void> _initWifi() async {
    if (!await WiFiForIoTPlugin.isConnected()) {
      bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isWifiEnabled) {
        await WiFiForIoTPlugin.setEnabled(true);
      }
      await _connectToWifi();
    }
  }

  Future<void> _connectToWifi() async {
    try {
      // Connect to Wi-Fi network
      bool isConnected = await WiFiForIoTPlugin.connect(
        'Semaforo',
        password: '12345678',
        security: NetworkSecurity.WPA,
      );

      if (isConnected) {
        setState(() {
          _circleColor = Colors.green;
          _playAudio('toque.mp3');
        });
      } else {
        print('Failed to connect to Wi-Fi');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _playAudio(String assetPath) async {
    await _audioPlayer.stop(); // Stop previous playback
    await _audioPlayer.play(AssetSource(assetPath));
    await _audioPlayer.setVolume(1);
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
                    _circleColor == Colors.green ? 'Avançar' : 'Parar2',
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

  void _simulateArduinoSignal() async {
    await _initWifi();
  }
}

void main() {
  runApp(MaterialApp(home: SecondPage()));
}
