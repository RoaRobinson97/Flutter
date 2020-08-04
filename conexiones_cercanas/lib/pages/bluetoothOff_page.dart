import 'package:conexiones_cercanas/utils/alarm.dart';
import 'package:conexiones_cercanas/utils/blinking_text.dart';
import 'package:conexiones_cercanas/utils/logout_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BluetoothOffScreen extends StatefulWidget {

    final BluetoothState state;
    final GoogleSignIn googleSignIn;
    final FirebaseUser user;

  const BluetoothOffScreen({Key key, this.state, this.googleSignIn, this.user}) : super(key: key);


  @override
  _BluetoothOffScreenState createState() => _BluetoothOffScreenState();
}

class _BluetoothOffScreenState extends State<BluetoothOffScreen> {

@override
void initState() {
super.initState();
}
  
  @override
  Widget build(BuildContext context) {

    Alarma alarma;
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white,
            ),
            blinkingText('Turn On Bluetooth adapter'),
            
          ],
        ),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            logout_button(context, widget.user, widget.googleSignIn, alarma),
            SizedBox(height: 10),
            Container(child: Text('Log Out', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold ),),),
          ],
        ),
    );
  }

  @override
void dispose() {
super.dispose();

}
}