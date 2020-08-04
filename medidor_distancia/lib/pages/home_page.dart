
import 'package:flutter/material.dart';
import 'package:medidor_distancia/blocs/radar.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  
  final _bloc = RadarBLoC();


  @override
  dispose(){
  super.dispose();
  _bloc.dispose();
}

  @override
  Widget build(BuildContext context) {

 WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {  
   if (_bloc.getRadar() == false){
       _bloc.radar_event_sink.add(DetectEvent());
   }
  }));



      
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<bool>(
          stream:  _bloc.stream_radar,
          initialData: false,
          builder:(context, snapshot){
            return Text(snapshot.data.toString());
          }
        ),
      ),
   );

  }
  
}

