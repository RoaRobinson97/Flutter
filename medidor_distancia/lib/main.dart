import 'package:flutter/material.dart';
import 'package:medidor_distancia/blocs/validar_login.dart';
import 'package:medidor_distancia/pages/home_page.dart';
import 'package:medidor_distancia/pages/login_page.dart';
 
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
