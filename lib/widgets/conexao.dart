import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wi-Fi Connection Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String ssid = 'Semaforo'; // Nome da rede Wi-Fi
  final String password = '12345678'; // Senha da rede Wi-Fi

  @override
  void initState() {
    super.initState();
    connectToWifi();
  }

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
      appBar: AppBar(
        title: Text('Wi-Fi Connection Example'),
      ),
      body: Center(
        child: Text('Connecting to Wi-Fi...'),
      ),
    );
  }
}
