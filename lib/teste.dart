import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wi-Fi and HTTP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String websiteData = "No data";

  @override
  void initState() {
    _initWifi();
    super.initState();
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

  Future<void> fetchDataFromWebsite() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.4.1/status"));
      if (response.statusCode == 200) {
        setState(() {
          websiteData = response.body;
        });
      } else {
        print("Failed to fetch data from website");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wi-Fi and HTTP Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchDataFromWebsite();
              },
              child: Text("Fetch Data from Website"),
            ),
            SizedBox(height: 20),
            Text("Website Data:"),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(websiteData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
