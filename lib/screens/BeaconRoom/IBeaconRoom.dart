import 'package:flutter/material.dart';
import 'package:flutter_b/screens/BeaconRoom/detal.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';

class IBeaconRoom extends StatelessWidget {
  final IBeacon iBeacon;

  IBeaconRoom({@required this.iBeacon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(right: 20, top: 20),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/beacon-testing.png')),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Room : ${iBeacon.name}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 12,
                ),
                MaterialButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return NoteDetail(iBeacon.name);
                      })),
                  color: Color(0xff73bca0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
