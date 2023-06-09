import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/widgets/alert_dialog_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/user_data.dart';

class UserDetailScreen extends StatefulWidget {
  String? img;
  String? nam;
  String? id;
  String? phone;
  String? email;
  double? longitute;
  double? latitetute;
  String? carName;
  String? carNumber;
  String? idNumber;

  UserDetailScreen(
      {this.longitute,
      this.id,
      this.nam,
      this.img,
      this.phone,
      this.email,
      this.latitetute,
      this.carName,
      this.carNumber,
      this.idNumber});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  double? latitue;
  double? longitute;
  List<Placemark>? placemark;
  String location = '';
  UserData? userdata;

  String? patientName;
  double? patienLatitue;
  double? patientLongitute;
  String? patientId;
  String? patientPhone;

  getDecodeLocation() {
    setState(() {
      latitue = widget.latitetute;
      longitute = widget.longitute;
      getLocation();
    });
  }

  getLocation() async {
    placemark = await placemarkFromCoordinates(
      latitue!.toDouble(),
      longitute!.toDouble(),
    );
    setState(() {
      location =
          '${placemark![0].street}, ${placemark![0].subAdministrativeArea} , ${placemark![0].locality}, ${placemark![0].administrativeArea}, ${placemark![0].country}';
    });
  }
  final user = FirebaseAuth.instance.currentUser!;

  getUserData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: user.uid)
        .get();
    if (res.docs.isNotEmpty) {
      setState(() {
        userdata =
            UserData.fromMap(res.docs.first.data() as Map<String, dynamic>);
        patienLatitue = userdata!.latituelocation;
        patientLongitute = userdata!.longitudelocation;
        patientName = userdata!.fname;
        patientId = userdata!.id;
        patientPhone = userdata!.phone;
      });
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDecodeLocation();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'DETAIL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 29.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // final User user = auth.currentUser!;
              await FirebaseFirestore.instance
                  .collection('Request')
                  .doc(patientId)
                  .set({
                "patientName": patientName.toString(),
                "patientAdressLatitue": patienLatitue,
                "patientAdressLongitue": patientLongitute,
                "PatientPhoneNumber": patientPhone,
                'DriverName': widget.nam,
                "DriverPhone": widget.phone,
                "DriverIdNumber": widget.idNumber,
                'RequestId': widget.id,
                'PatientId' : patientId,
                'DriverLatitute' : widget.latitetute,
                'DriverLongitute' : widget.longitute,
                'DriverPicture' : widget.img,

              }).then((value) {
                Navigator.pop(context);
              });
              AlertDialogWidget.showSnakcbar(context, 'Request Has been sent');
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Request',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Image.network(
              '${widget.img}',
              fit: BoxFit.cover,
              height: 100.h,
              width: 100.h,
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.nam}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.carName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.nam}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      widget.email!.isEmpty
                          ? 'Not in Record'
                          : '${widget.email}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.phone!.isEmpty
                              ? 'Not in Record'
                              : '${widget.phone}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                openWhatsApp();
                              },
                              icon: Icon(
                                Icons.message,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _makePhoneCall(widget.phone!);
                              },
                              icon: Icon(
                                Icons.call,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      placemark == null ? 'Your Adress' : '${location}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //for phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //for whatsapp

  openWhatsApp() async {
    var whatsapp = widget.phone;
    var androidUrl =
        "whatsapp://send?phone=$whatsapp&text=Share Your Current Location";
    try {
      await launchUrl(Uri.parse(androidUrl));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        content: Text(
          "Please Install WHATSAPP",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
