import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }

  final Audio player = Audio();
}

class Audio {
  bool isAudioOff = false;
  final player = AudioPlayer();

  bool getAudioStatus() {
    return isAudioOff;
  }

  Future<void> toggleAudioStatus() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    isAudioOff = !isAudioOff;
    await instance.setBool('buttonAudio', isAudioOff);
  }

  Future<void> loadAudioStatus() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    isAudioOff = instance.getBool('buttonAudio') ?? false;
  }

  void playClick() {
    if (!isAudioOff) {
      player.play(AssetSource("sci-fi-click.wav"));
    }
  }

  void playError() {
    if (!isAudioOff) {
      player.play(AssetSource("error-music.mp3"));
    }
  }
}
