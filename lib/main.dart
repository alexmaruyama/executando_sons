import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache(prefix: 'audios/');
  bool _tocando = false;
  double _volume = 0.5;

  _executar() async {
    if (_tocando == false) {
      _audioPlayer = await _audioCache.play('musica.mp3');
      _tocando = true;
    } else {
      _audioPlayer.resume();
    }
  }

  _pausar() async {
    await _audioPlayer.pause();
  }

  _parar() async {
    await _audioPlayer.stop();
  }

  _controlarVolume(double valor) {
    setState(() {
      _volume = valor;
    });
    _audioPlayer.setVolume(_volume);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Executar som'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Slider(
              value: _volume,
              onChanged: (valor) {
                _controlarVolume(valor);
              },
              min: 0,
              max: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _executar();
                },
                child: Image.asset(
                  'assets/imagens/executar.png',
                  height: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pausar();
                },
                child: Image.asset(
                  'assets/imagens/pausar.png',
                  height: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _parar();
                },
                child: Image.asset(
                  'assets/imagens/parar.png',
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
