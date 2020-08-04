import 'package:conexiones_cercanas/utils/alarm.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:just_audio/just_audio.dart';

class BluetoothScanner {

  Alarma _alarma;
  FlutterBlue _flutterBlue;
  bool sonando = false;

  BluetoothScanner(){
    this._flutterBlue = FlutterBlue.instance;
    this._alarma = new Alarma();
  }
  
  scan()async{

     _alarma.audioController.listen((event) {
      if (event.state == AudioPlaybackState.playing){
        sonando = true;
      }else{
        sonando = false;
      }
     });
    
    _flutterBlue.stopScan();
    _flutterBlue.startScan(timeout: Duration(seconds: 2), allowDuplicates: true);
    var subscription = _flutterBlue.scanResults.listen((results) {
    // do something with scan results
    for (ScanResult r in results) {
        print('${r.advertisementData.localName} found! rssi: ${r.rssi}');
        if (r.rssi < -70){
          if(sonando == false){
           _alarma.sonar();
          }
        }
    }
    print('Escaneando');
    });
    _flutterBlue.scanResults.drain();
  } 
}