import 'package:distancia_bluetooth/pages/home_page.dart';
import 'package:distancia_bluetooth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'blocs/validar_login.dart';
 
void main(){
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  String _start;
  Validar login = new Validar();

  login.esValida();

  if (login.getLogin() == false){
    _start = 'login';
  } else  {
    _start = 'home';
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;
print('hola');

flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
var subscription = flutterBlue.scanResults.listen((results) {
    // do something with scan results
    for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
    }
});
    print('chao');


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'home'  : (BuildContext context) => HomePage(),
        'login' : (BuildContext context) => LoginPage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        canvasColor: Color(0xFFFF80AB),
      ),
      initialRoute: _start,
      
    ); 
  }
}
