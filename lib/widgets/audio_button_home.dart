import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/my_touch_page.dart'; // Importe a página correta

class AudioButton extends StatefulWidget {
  const AudioButton({super.key});

  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('conexao.mp3'));
    await _audioPlayer.setVolume(1);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _playAudio();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyTouchPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF247BA0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: SizedBox(
        height: 1800,
        width: 2000,
        child: Image.asset('assets/microfone.png'),
      ),
    );
  }
}
