
import 'package:zapiti_desafio/app/utils/music/soun_path.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundUtils {
  static playRemoteFile() async {

    try {
      AudioCache audioCache = AudioCache(
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
      );

      await   audioCache.play(SoundPath.sound);
    } catch (e) {
      print(e);
    }
  }
}