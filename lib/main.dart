import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(MaterialApp(home: LoadingScreen()));
}

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
  }

  Future<void> _loadDataAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF247BA0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 50),
              tween: Tween<double>(begin: 0, end: 10),
              builder: (BuildContext context, double value, Widget? child) {
                return Transform.rotate(
                  angle: value * 6.28319,
                  child: Icon(
                    Icons.hourglass_empty,
                    color: Color(0xFF13293D),
                    size: 100,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyTouchPage()),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFF247BA0),
        appBar: AppBar(
          backgroundColor: Color(0xFF13293D),
          automaticallyImplyLeading: false,
          title: Text(
            'Sinal verde',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                final player = AudioPlayer();
                await player.play(UrlSource('https://file-examples.com/storage/fe7bb0e37864d66f29c40ee/2017/11/file_example_WAV_1MG.wav'));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTouchPage()),
                );
              },
              child: SizedBox(
                height: 1800,
                width: 2000,
                child: Image.asset('assets/microfone.png'),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF247BA0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFF247BA0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
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
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Parar',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'verdana',
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Avançar',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'verdana',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
