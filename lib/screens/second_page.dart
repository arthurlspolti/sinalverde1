import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String websiteData = "No data";
  Color _circleColor = Colors.white54;
  AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _timer;

  String _previousWebsiteData = ''; // Para acompanhar o status anterior
  bool _audioPlayed = false; // Para controlar se o áudio foi tocado

  @override
  void initState() {
    super.initState();
    _initWifi();
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      fetchDataFromWebsite();
    });
  }

  String semaforoStatus = 'Carregando...';

  Future<void> fetchDataFromWebsite() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.4.1/status"));
      if (response.statusCode == 200) {
        setState(() {
          websiteData = response.body;
          if (websiteData != _previousWebsiteData) {
            _previousWebsiteData = websiteData;
            _audioPlayed = false;
          }
        });
      } else {
        print("Failed to fetch data from website");
      }
    } catch (e) {
      print("Error fetching data: $e");
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
        print("Connected to Wi-Fi");
      } else {
        print("Failed to connect to Wi-Fi");
      }
    } catch (e) {
      print("Error connecting to Wi-Fi: $e");
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
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (!_audioPlayed) {
          if (orientation == Orientation.portrait) {
            // Lógica para orientação retrato
            if (websiteData.contains('A Verde')) {
              _circleColor = Colors.green;
              _playAudio('sinalverde.mp3');
            } else if (websiteData.contains('A Vermelho')) {
              _circleColor = Colors.red;
              _playAudio('sinalvermelho.mp3');
            } else if (websiteData.contains('A Piscando')) {
              _circleColor = Colors.grey;
              _playAudio('espera.mp3');
            }
          } else {
            // Lógica para orientação paisagem
            if (websiteData.contains('B Verde')) {
              _circleColor = Colors.green;
              _playAudio('sinalverde.mp3');
            } else if (websiteData.contains('B Vermelho')) {
              _circleColor = Colors.red;
              _playAudio('sinalvermelho.mp3');
            } else if (websiteData.contains('B Piscando')) {
              _circleColor = Colors.grey;
              _playAudio('espera.mp3');
            }
          }
          _audioPlayed = true;
        }

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
                        _circleColor == Colors.green
                            ? 'Avançar'
                            : _circleColor == Colors.red
                                ? 'Parar'
                                : _circleColor == Colors.grey
                                    ? 'Piscando'
                                    : 'Desconectado',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'verdana',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
