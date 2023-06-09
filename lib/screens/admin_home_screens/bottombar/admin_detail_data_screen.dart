import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/alert_dialog_widget.dart';

class AdminDataDetailScreen extends StatefulWidget {
  String? img;
  String? nam;
  String? id;
  String? phone;
  String? email;
  double? longitute;
  double? latitetute;

  AdminDataDetailScreen({
    this.longitute,
    this.id,
    this.nam,
    this.img,
    this.phone,
    this.email,
    this.latitetute,
  });

  @override
  State<AdminDataDetailScreen> createState() => _AdminDataDetailScreenState();
}

class _AdminDataDetailScreenState extends State<AdminDataDetailScreen> {
  double? latitue;
  double? longitute;
  List<Placemark>? placemark;
  String location = '';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDecodeLocation();
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
              final User user = FirebaseAuth.instance.currentUser!;
              await FirebaseFirestore.instance
                  .collection('Approve')
                  .doc(widget.id)
                  .set({
                "patientName": widget.nam,
                "patientAdressLatitue": widget.latitetute,
                "patientAdressLongitue": widget.longitute,
                "PatientPhoneNumber": widget.phone,
                'DriverName': user.displayName,
                "DriverPhone": user.phoneNumber,


              }).then((value) {
                Navigator.pop(context);
              });
              AlertDialogWidget.showSnakcbar(context, 'Request Has been Approved,Driver is on Way');
            },

            child: Text('Approve'),
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
