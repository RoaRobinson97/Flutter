import 'package:just_audio/just_audio.dart';

class Alarma {

AudioPlayer _player; 
Stream<FullAudioPlaybackState> audioController;
bool sonando = false;

  Alarma(){
    AudioPlayer.setIosCategory(IosCategory.playback);
    _player = new AudioPlayer();
  }

  sonar(){
    // audioController.listen((event) {
    //   if(event.state == AudioPlaybackState.connecting || event.buffering == true){
    //     print('cargando');}
    //   else if (event.state == AudioPlaybackState.playing){
    //     print('Sonando');
    //     sonando = true;
    //   } else if (event.state != AudioPlaybackState.playing){
    //     _player.play();
    //   }
    //  });
    _player.setAsset('assets/alarm.mp3');
    audioController = _player.fullPlaybackStateStream;
    _player.play();
    audioController.listen((event) { 
    if(event.state == AudioPlaybackState.playing){
      sonando = true;
    }else{
      sonando = false;    }
  });
  }

  stop(){
    _player.stop();
  }
  
  dispose(){
    _player.dispose();
  }
}