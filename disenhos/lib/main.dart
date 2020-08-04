import 'dart:io';
import 'package:disenhos/pages/basico_page.dart';
import 'package:disenhos/pages/botones_page.dart';
import 'package:disenhos/pages/scroll_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if ( Platform.isAndroid ) {
      
      SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
      ));
 
    } else if (Platform.isIOS) {
 
      SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white
      ));
      
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      routes: {
        'basico'  : (BuildContext context)  => BasicoPage(),
        'scroll'  : (BuildContext context)  => ScrollPage(),        
        'botones'  : (BuildContext context)  => BotonesPage(),

      },
      initialRoute: 'botones',
    
    );
  }
}