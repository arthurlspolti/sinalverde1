import 'package:flutter/material.dart';
import '../widgets/animated_hourglass_icon.dart';
import 'home_page.dart';
import 'package:wifi_iot/wifi_iot.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  
  
  void initState() {
    super.initState();
    _loadDataAndNavigate();
    connectToWifi();
  }

  Future<void> _loadDataAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageWidget()),
    );
  }

  final String ssid = 'Semaforo'; // Nome da rede Wi-Fi
  final String password = '12345678'; // Senha da rede Wi-Fi

  @override
  Future<void> connectToWifi() async {
    bool isConnected = await WiFiForIoTPlugin.connect(
      ssid,
      password: password,
      security: NetworkSecurity.WPA, // Replace with the appropriate security type
      joinOnce: true,
      withInternet: false,
      isHidden: false,
      timeoutInSeconds: 30,
    );

    if (isConnected) {
      print('Connected to Wi-Fi: $ssid');
    } else {
      print('Failed to connect to Wi-Fi: $ssid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF247BA0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedHourglassIcon(),
            SizedBox(height: 20),
            // Other widgets
          ],
        ),
      ),
    );
  }
}
