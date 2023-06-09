import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/home_screens/bottombar/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import '../../models/request_model.dart';
import '../../models/user_data.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // UserData? userData;
  List<RequestData> reqData = [];

  double? latitue;
  double? longitute;
  List<Placemark>? placemark;

  final user = FirebaseAuth.instance.currentUser!;
  String name = '';
  String img = '';
  String phone = '';
  String email = '';

  getLocation() async {
    placemark = await placemarkFromCoordinates(
      latitue!.toDouble(),
      longitute!.toDouble(),
    );
  }

  getUserData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('Request')
        .where('PatientId', isEqualTo: user.uid)
        // .where('id', isEqualTo: user.uid)
        .get();
    if (res.docs.isNotEmpty) {
      setState(() {
        reqData = res.docs
            .map((e) => RequestData.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        name = reqData[0].DriverName!;
        img = reqData[0].DriverPicture!;
        phone = reqData[0].DriverPhone!;
        latitue = reqData[0].DriverLatitute;
        longitute = reqData[0].DriverLongitute;

        getLocation();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Activity',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 22.0, right: 22),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Past',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 22.sp,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //       Container(
            //         height: 30.h,
            //         width: 30.w,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.withOpacity(0.2),
            //           shape: BoxShape.circle,
            //         ),
            //         child: Center(
            //           child: Icon(
            //             Icons.filter_list,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: reqData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 95.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.network(
                          '${reqData[index].DriverPicture}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      placemark == null
                          ? ''
                          : '${placemark![0].street} , ${placemark![0].locality}, ${placemark![0].administrativeArea}, ${placemark![0].country}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Driver Name = ${reqData[index].DriverName}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // Text(
                        //   'Distance = 4 KM',
                        //   style: TextStyle(
                        //     color: Colors.black54,
                        //     fontSize: 13.sp,
                        //     fontWeight: FontWeight.w300,
                        //   ),
                        // ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('Request')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .delete();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ),
                        );
                      },
                      child: Container(
                        height: 30.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Cancle Ride',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
