import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOffScreen extends StatefulWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

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
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }

  @override
void dispose() {
super.dispose();

}
}