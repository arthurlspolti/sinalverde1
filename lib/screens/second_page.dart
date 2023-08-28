import 'dart:async';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:network_info_plus/network_info_plus.dart';

import 'package:http/http.dart' as http;

import 'package:connectivity/connectivity.dart';

import 'package:wifi_iot/wifi_iot.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String websiteData = "No data";

  Color _circleColor = Colors.white54;

  AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _timer;

  String _previousWebsiteData = '';

  bool _audioPlayed = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchDataFromWebsite();
    });

    _connectToWifi();
  }

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

          if (!_audioPlayed) {
            if (websiteData == 'Sinal Verde') {
              _circleColor = Colors.green;

              _playAudio('sinalverde.mp3');
            } else if (websiteData == 'Sinal Vermelho') {
              _circleColor = Colors.red;

              _playAudio('sinalvermelho.mp3');
            }

            if (websiteData == 'Sinal Piscando') {
              _circleColor = Colors.grey;

              _playAudio('espera.mp3');
            }

            _audioPlayed = true;
          }
        });
      } else {
        print("Failed to fetch data from website");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> _connectToWifi() async {
    try {
      List<String> availableNetworks = ['semaforo2', 'semaforo1'];

      String nearestNetwork = '';

      NetworkInfo networkInfo = NetworkInfo();

      ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.wifi) {
        nearestNetwork = await networkInfo.getWifiName() ?? '';
      }

      if (nearestNetwork.isNotEmpty &&
          availableNetworks.contains(nearestNetwork)) {
        print("Already connected to the nearest Wi-Fi: $nearestNetwork");

        return;
      }

      for (String network in availableNetworks) {
        bool isConnected = await WiFiForIoTPlugin.connect(
          network,
          password: '12345678',
          security: NetworkSecurity.WPA,
        );

        if (isConnected) {
          print("Connected to Wi-Fi: $network");

          break; // Sair do loop se conectado a uma rede
        } else {
          print("Failed to connect to Wi-Fi: $network");
        }
      }
    } catch (e) {
      print("Error connecting to Wi-Fi: $e");
    }
  }

  Future<void> _playAudio(String assetPath) async {
    await _audioPlayer.stop();

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
  }
}