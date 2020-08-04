import 'dart:async';
import 'package:conexiones_cercanas/utils/alarm.dart';
import 'package:conexiones_cercanas/utils/beacon_broadcast.dart';
import 'package:conexiones_cercanas/utils/devices.dart';
import 'package:conexiones_cercanas/utils/logout_button.dart';
import 'package:conexiones_cercanas/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class HomePage extends StatefulWidget {
  
    final GoogleSignIn googleSignIn;
    final FirebaseUser user;

  const HomePage({Key key,this.googleSignIn, this.user}) : super(key: key);


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  BeaconProvider beaconProvider = BeaconProvider();
  Timer timer;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final Alarma alarma  = new Alarma();
  bool isSwitched = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
  super.initState();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project   
     // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

  timer = Timer.periodic(Duration(seconds: 6), (Timer t){
  if(this.mounted){
    setState(() {
    FlutterBlue.instance.stopScan();
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 6));
    var subscription = flutterBlue.scanResults.listen((results) {
    // do something with scan results
    for (ScanResult r in results) {
        if(r.rssi >= -69 && alarma.sonando == false){ 
          if(isSwitched == false){
            alarma.sonar();
          }else{
            _showNotificationWithoutSound();
          }
        }else if(( r.rssi < -69 && alarma.sonando == true) || ( r.rssi < -69 && alarma.sonando == true) || (results == null && alarma.sonando == true)){
          alarma.stop();
        }
    }
});
    });
    }
  });
  }

  @override
  void dispose() {
    super.dispose();
    alarma.stop();
  }

 @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(224, 224, 224, 1),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            logout_button(context, widget.user, widget.googleSignIn, alarma),
            SizedBox(height: 10),
            Container(child: Text('Log Out', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold ),),),
          ],
        ),
        body: 
          Stack( 
            alignment: Alignment.bottomLeft,
            children: [
              Column(
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height)*0.12,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(247, 131, 97, 1),
                      Color.fromRGBO(245, 75, 100, 1),
                      ]),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Nearby Devices', style: TextStyle(color: Colors.white70, fontSize: 24, fontWeight: FontWeight.w700),),
                    )),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<List<BluetoothDevice>>(
                        stream: Stream.periodic(Duration(seconds: 4))
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
                Container(height: 50,)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Text('Silent\nmode', style: TextStyle(fontSize: 12, color: Colors.black87),),
                 Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.blueGrey,
                  activeColor: Colors.blueAccent,
                ),
                /* new RaisedButton(
                  onPressed: _showNotificationWithoutSound,
                  child: new Text('Show Notification Without Sound'),
                ),*/
                ],
              ),
            )
            ],
          ),
      );
   
  }
   Future onSelectNotification(String payload) async {
  }

  Future _showNotificationWithoutSound() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      playSound: false, importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics =
      new IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Device Detected!',
    'You are too close to another device.',
    platformChannelSpecifics,
    payload: 'No_Sound',
  );
}
}