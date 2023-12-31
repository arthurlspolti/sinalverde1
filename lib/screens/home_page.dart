import 'package:flutter/material.dart';
import '../widgets/audio_button_home.dart';
import 'my_touch_page.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio(); // Chama a função para reproduzir o áudio
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('toque.mp3'));
    await _audioPlayer.setVolume(1);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
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
            child: AudioButton(),
          ),
        ),
      ),
    );
  }
}
