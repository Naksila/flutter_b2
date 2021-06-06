import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_b/screens/BeaconRoom/IBeaconRoom.dart';
import 'package:flutter_b/header.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';

class Scanbeacon extends StatefulWidget {
  Scanbeacon({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ScanbeaconState createState() => new _ScanbeaconState();
}

class _ScanbeaconState extends State<Scanbeacon> {
  FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<int, Beacon> beacons = new Map();
  bool isScanning = false;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    super.dispose();
  }

  _clearAllBeacons() {
    setState(() {
      beacons = Map<int, Beacon>();
    });
  }

  _startScan() {
    print("Scanning now");
    _scanSubscription = flutterBlueBeacon
        .scan(timeout: const Duration(seconds: 1))
        .listen((beacon) {
      print('localName: ${beacon.scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${beacon.scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${beacon.scanResult.advertisementData.serviceData}');
      setState(() {
        beacons[beacon.hash] = beacon;
      });
    }, onDone: _stopScan);

    setState(() {
      isScanning = true;
    });
  }

  _stopScan() {
    print("Scan stopped");
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  _buildScanningButton() {
    if (state != BluetoothState.on) {
      return null;
    }
    if (isScanning) {
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: _stopScan,
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          backgroundColor: Color(0xff73bca0),
          child: new Icon(Icons.search),
          onPressed: _startScan);
    }
  }

  _buildScanResultTiles() {
    return beacons.values.map<Widget>((b) {
      if (b is IBeacon) {
        return IBeaconRoom(iBeacon: b);
      }

      return Card();
    }).toList();
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }

    tiles.addAll(_buildScanResultTiles());

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          backgroundColor: Color(0xff468189),
          floatingActionButton: _buildScanningButton(),
          body: Container(
            child: Column(
              children: [
                Header(),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Color(0xffFFFFFe)),
                  child: Stack(
                    children: <Widget>[
                      Text(
                        'Scan Beacon for check in class room',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      (isScanning) ? _buildProgressBarTile() : new Container(),
                      new ListView(
                        children: tiles,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
