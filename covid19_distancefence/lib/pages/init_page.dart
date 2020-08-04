import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'bluetoothOff_page.dart';
import 'workingGood_page.dart';

class InitPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return HomePage();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
  
}