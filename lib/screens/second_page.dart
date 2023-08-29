import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SecondPage());
}


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  Color _circleColor = Colors.grey;
  String _semaforoStatus = 'Carregando...';

  @override
  void initState() {
    super.initState();
    _connectToWifi();
    _startCheckingStatusLoop();
  }

  Future<void> _connectToWifi() async {
    try {
      // Connect to Wi-Fi network
      bool isConnected = await WiFiForIoTPlugin.connect(
        'Semaforo1',
        password: '12345678',
        security: NetworkSecurity.WPA,
      );

      if (isConnected) {
        // Do something after successful connection
      } else {
        print('Failed to connect to Wi-Fi');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _startCheckingStatusLoop() async {
    while (true) {
      await fetchSemaforoStatus();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> fetchSemaforoStatus() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.4.1/status'));

    if (response.statusCode == 200) {
      setState(() {
        _semaforoStatus = response.body;
      });

      if (_semaforoStatus == 'Sinal Verde') {
        setState(() {
          _circleColor = Colors.green;
          // Execute actions for 'Sinal Verde'
        });
      } else if (_semaforoStatus == 'Sinal Vermelho') {
        setState(() {
          _circleColor = Colors.red;
          // Execute actions for 'Sinal Vermelho'
        });
      }
    } else {
      print('Failed to fetch semáforo status');
    }
  } catch (e) {
    print('Error fetching semáforo status: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Connection Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: _circleColor,
            ),
            const SizedBox(height: 20),
            Text('Status do Semáforo: $_semaforoStatus'),
          ],
        ),
      ),
    );
  }
}
