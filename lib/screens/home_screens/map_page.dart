import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../models/user_data.dart';

class CustomGoogleMap extends StatefulWidget {
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  UserData? userData;
  String? firstName ;
  String? lastName ;

  final user = FirebaseAuth.instance.currentUser!;
  getUserData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: user.uid)
        .get();
    if (res.docs.isNotEmpty) {
      setState(() {
        userData =
            UserData.fromMap(res.docs.first.data() as Map<String, dynamic>);
        firstName = userData!.fname;
        lastName = userData!.lname;

      });
    }

  }

  LatLng _intitialcamerapositon = LatLng(30.6952325, 73.0904565);

  // static const LatLng sourceLocation = LatLng(20.597, 78.9629);
  // static const LatLng DestinationLocation = LatLng(20.597, 78.8758);

  // Set<Marker> markers = Set();

  Location location = Location();
  GoogleMapController? controller;

  void _onMapCreated(GoogleMapController value) {
    controller = value;
    location.onLocationChanged.listen((event) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              double.parse(event.latitude.toString()),
              double.parse(event.longitude.toString()),
            ),
            zoom: 20,
          ),
        ),
      );
    });
  }
  //
  // List<Marker> marker = [];
  // List<Marker> listMarker = const [
  //   Marker(
  //     markerId: MarkerId('1'),
  //     position: LatLng(20.597, 78.9629),
  //     infoWindow: InfoWindow(title: 'ISB'),
  //     icon: BitmapDescriptor.defaultMarker,
  //   ),
  //
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // marker.addAll(listMarker);

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.red,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Google Map Adress',
      //     style: TextStyle(
      //       fontSize: 18,
      //       color: Colors.red,
      //     ),
      //   ),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _intitialcamerapositon,
              ),
              mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              // markers: Set<Marker>.of(marker),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 10, right: 60, top: 40, bottom: 40),
                child: MaterialButton(
                  onPressed: () async {
                    await location.getLocation().then((value) {
                      setState(() async {
                        // checkOutProvider.setLocation = value;
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final User user = auth.currentUser!;
                        UserData userdata = UserData(
                            id: user.uid,
                            fname: firstName,
                            lname: lastName,
                            phone: user.phoneNumber.toString(),
                            email: user.email,
                            latituelocation: value.latitude,
                            longitudelocation:value. longitude,
                            image:
                            'https://i.pinimg.com/originals/3c/0f/26/3c0f26341e7c1a53ba0212ae6fce4d27.png',
                            pushToken: '');
                        return await FirebaseFirestore.instance
                            .collection('user')
                            .doc(user.uid)
                            .set(userdata.toMap())
                            .then((value) {
                          Navigator.pop(context);
                        });
                      });
                    });
                  },
                  child: Text(
                    'Set Location',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.red,
                  shape: StadiumBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
