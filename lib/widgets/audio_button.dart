import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/my_touch_page.dart'; // Importe a página correta

class AudioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final player = AudioPlayer();
        await player.play(UrlSource('https://file-examples.com/storage/fe7bb0e37864d66f29c40ee/2017/11/file_example_WAV_1MG.wav'));
        // Não é necessário navegar para MyTouchPage aqui
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
    );
  }
}
