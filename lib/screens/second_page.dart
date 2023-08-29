import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String websiteData = "No data";
  Color _circleColor = Colors.white54;
  Timer? _timer;

  String _previousWebsiteData = '';

  @override
  void initState() {
    super.initState();
    _connectToStrongestWifi();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchDataFromWebsite();
    });
  }

  Future<void> fetchDataFromWebsite() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.4.1/status"));
      if (response.statusCode == 200) {
        setState(() {
          websiteData = response.body;
          if (websiteData != _previousWebsiteData) {
            _previousWebsiteData = websiteData;
          }

          if (websiteData == 'Sinal Verde') {
            _circleColor = Colors.green;
          } else if (websiteData == 'Sinal Vermelho') {
            _circleColor = Colors.red;
          } else if (websiteData == 'Sinal Piscando') {
            _circleColor = Colors.grey;
          } else {
            _circleColor = Colors.white54;
          }
        });
      } else {
        print("Failed to fetch data from website");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> _connectToStrongestWifi() async {
    try {
      List<WifiNetwork> networks = await WiFiForIoTPlugin.loadWifiList();
      List<WifiNetwork> filteredNetworks = networks.where((network) => network.ssid == 'semaforo1' || network.ssid == 'semaforo2').toList();
      filteredNetworks.sort((a, b) => b.level?.compareTo(a.level ?? 0) ?? 0);
      WifiNetwork strongestNetwork = filteredNetworks.first;
      await WiFiForIoTPlugin.connect(strongestNetwork.ssid!, password: '12345678', security: NetworkSecurity.WPA);
    } catch (e) {
      print("Error connecting to Wi-Fi: $e");
    }
  }

  @override
  void dispose() {
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
                    _circleColor == Colors.green ? 'Avançar' : _circleColor == Colors.red ? 'Parar' : _circleColor == Colors.grey ? 'Piscando' : 'Desconectado',
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
