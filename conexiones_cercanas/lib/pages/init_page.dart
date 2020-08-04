import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'bluetoothOff_page.dart';
import 'workingGood_page.dart';

class InitPage extends StatelessWidget {

  GoogleSignIn _googleSignIn;
  FirebaseUser _user;

  InitPage(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return HomePage( googleSignIn: _googleSignIn, user: _user);
            }
            return BluetoothOffScreen(state: state, googleSignIn: _googleSignIn, user: _user);
          }),
    );
  }
  
}