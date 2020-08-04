import 'dart:async';
import 'package:uuid_type/uuid_type.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';

class BeaconProvider{

  final Uuid _uuid = RandomBasedUuidGenerator().generate();

  BeaconBroadcast beaconBroadcast;

  BeaconStatus _isTransmissionSupported;
  bool _isAdvertising;
  StreamSubscription<bool> _isAdvertisingSubscription;

  BeaconProvider(){
    this.beaconBroadcast = BeaconBroadcast();
    this._isAdvertising = false;
    this._isAdvertisingSubscription = _isAdvertisingSubscription;
    this._isTransmissionSupported = _isTransmissionSupported;
    checkTransmissionSupported();
    isAdvertisingSubscription();
    start();

  }

  uuid(){
    return _uuid;
  }

   StreamSubscription<bool> stream(){
     return _isAdvertisingSubscription;
   }

  checkTransmissionSupported(){
    beaconBroadcast.checkTransmissionSupported().then((isTransmissionSupported){    
      _isTransmissionSupported  = isTransmissionSupported;
    });
  }

  isAdvertisingSubscription(){
    beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
    _isAdvertising = isAdvertising; });
  }

  start(){
    beaconBroadcast.setUUID(_uuid.toString()).setMinorId(1).setMajorId(100).start();
  }

  cancelSubscription(){
    beaconBroadcast.stop();
    _isAdvertisingSubscription.cancel();
  }

}
