import 'dart:async';
import 'package:conexiones_cercanas/utils/beacon_broadcast.dart';
import 'package:conexiones_cercanas/utils/blue_scaner.dart';
import 'package:conexiones_cercanas/utils/devices.dart';
import 'package:conexiones_cercanas/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  BeaconProvider beaconProvider = BeaconProvider();
  BluetoothScanner scanner = BluetoothScanner();
  Timer timer;

  @override
  initState() {
  super.initState();
  timer = Timer.periodic(Duration(seconds: 4), (Timer t){
  if(this.mounted){
    setState(() {
    scanner.scan();
    print(beaconProvider.uuid());
    });
    }
  });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 2),allowDuplicates: true),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
  super.dispose();
  }
}







// import 'dart:async';
// import 'package:conexiones_cercanas/utils/beacon_broadcast.dart';
// import 'package:conexiones_cercanas/utils/blue_scaner.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {

//   BeaconProvider beaconProvider = BeaconProvider();
//   BluetoothScanner scanner = BluetoothScanner();
//   Timer timer;

//   @override
//   initState() {
//   super.initState();
//   timer = Timer.periodic(Duration(seconds: 3), (Timer t){
//   if(this.mounted){
//     setState(() {
//     scanner.scan();
//     print(beaconProvider.uuid());
//     });
//     }
//   });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Material App Bar'),
//         ),
//         body: Center(
//           child: Container(
//             child: Text('Hello World'),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//   super.dispose();
//   }
// }

