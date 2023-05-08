import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class UserDetailScreen extends StatefulWidget {
  String? img;
  String? nam;
  String? id;
  String? phone;
  String? email;
  double? longitute;
  double? latitetute;

  UserDetailScreen({
    this.longitute,
    this.id,
    this.nam,
    this.img,
    this.phone,
    this.email,
    this.latitetute,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
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
      location = '${placemark![0].street}, ${placemark![0]
          .subAdministrativeArea} , ${placemark![0].locality}, ${placemark![0]
          .administrativeArea}, ${placemark![0].country}';

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
          'PATIENT DETAIL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 29.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                    child: Text(
                      widget.phone!.isEmpty
                          ? 'Not in Record'
                          : '${widget.phone}',
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
                    child: Text(
                      placemark == null
                          ? 'Your Adress'
                          : '${location}',
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
}
