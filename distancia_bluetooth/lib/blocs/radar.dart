import 'dart:async';

abstract class RadarEvent{}

class DetectEvent extends RadarEvent{}

// RadarBloc.dart 
class RadarBLoC{

  bool _radar = false;
 // BluetoothProvider dispositivos = BluetoothProvider();

  
  // to be updated with a StreamSink!
  Future _detect(RadarEvent event) async{

  //_radar = encontroDispositivo();

  if(  _radar == true ){
    radar_sink.add(false);
    _radar = false;
  } else {
     radar_sink.add(true);
     _radar = true;
  }

  }

  bool getRadar(){
    return _radar;
  }

  RadarBLoC() {  _radarEventController.stream.listen(_detect);  }

// init StreamController
final _radarStreamController = StreamController<bool>();
StreamSink<bool> get radar_sink => _radarStreamController.sink;
// expose data from stream
Stream<bool> get stream_radar => _radarStreamController.stream;

final _radarEventController = StreamController<RadarEvent>();
// expose sink for input events
Sink <RadarEvent> get radar_event_sink { 
   return _radarEventController.sink;
}


dispose(){
  _radarStreamController.close();
  _radarEventController.close();
}

  /*bool encontroDispositivo() {
    Dispositivo buscandoDispositivos = Dispositivo();
    bool respuesta = false;
    _radar = true;
    buscandoDispositivos.scan();
    respuesta = buscandoDispositivos.resultado;
    _radar = false;
    return respuesta;

  }*/

}


