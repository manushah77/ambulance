import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/admin_home_screens/bottombar/admin_detail_data_screen.dart';
import 'package:embulance/screens/home_screens/bottombar/user_detail.dart';
import 'package:embulance/screens/home_screens/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/request_model.dart';
import '../../models/user_data.dart';
import 'admin_map_page.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  UserData? userData;
  List<RequestData> userdata = [];

  double? latitue;
  double? longitute;
  List<Placemark>? placemark;

  final user = FirebaseAuth.instance.currentUser!;

  getUserData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('Driver')
        .where('id', isEqualTo: user.uid)
        .get();
    if (res.docs.isNotEmpty) {
      setState(() {
        userData =
            UserData.fromMap(res.docs.first.data() as Map<String, dynamic>);
        latitue = userData!.latituelocation;
        longitute = userData!.longitudelocation;
        getLocation();
      });
    }

    QuerySnapshot rest = await FirebaseFirestore.instance
        .collection('Request')
        .where('RequestId', isEqualTo: user.uid)
        .get();
    if (rest.docs.isNotEmpty) {
      setState(() {
        userdata = rest.docs
            .map((e) => RequestData.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        latitue = userData!.latituelocation;
        longitute = userData!.longitudelocation;
        getLocation();
      });
    }
  }

  getLocation() async {
    placemark = await placemarkFromCoordinates(
      latitue!.toDouble(),
      longitute!.toDouble(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'ADMIN HOME',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminCustomGoogleMap(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Container(
                    height: 45.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  title: Text(
                    // '',
                    placemark == null
                        ? 'Your Location'
                        : '${placemark![0].street}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    placemark == null
                        ? 'Your Adress'
                        : '${placemark![0].subAdministrativeArea} , ${placemark![0].locality}, ${placemark![0].administrativeArea}, ${placemark![0].country}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    opticalSize: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Request',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GridView.builder(
                  physics: ScrollPhysics(),
                  itemCount: userdata.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3 / 1,
                  ),
                  itemBuilder: (BuildContext ctx, indexx) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminDataDetailScreen(
                                nam: userdata[indexx].patientName,
                                img: userdata[indexx].DriverPicture,
                                latitetute: userdata[indexx].patientAdressLatitue,
                                longitute: userdata[indexx].patientAdressLongitue,
                                email: userdata[indexx].patientName,
                                phone: userdata[indexx].PatientPhoneNumber,
                                id: userdata[indexx].PatientId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            height: 105.h,
                            width: 170.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.network(
                                      '${userdata[indexx].DriverPicture}',
                                      height: 65.h,
                                      width: 65.w,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${userdata[indexx].patientName}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
