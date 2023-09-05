import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semaforo App',
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
  String semaforoStatus = 'Carregando...';

  Future<void> fetchSemaforoStatus() async {
    final response = await http.get(Uri.parse('http://192.168.4.1/status'));

    if (response.statusCode == 200) {
      setState(() {
        semaforoStatus = response.body;
      });
    } else {
      setState(() {
        semaforoStatus = 'Erro ao obter status';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semaforo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status do Semaforo:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              semaforoStatus,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchSemaforoStatus,
              child: Text('Atualizar Status'),
            ),
          ],
        ),
      ),
    );
  }
}
