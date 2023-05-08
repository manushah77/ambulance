import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/home_screens/account_screens/profile.dart';
import 'package:embulance/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user_data.dart';
import '../../welcome_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserData? userData;
  final user = FirebaseAuth.instance.currentUser!;
  String name = '';
  String img = '';
  String phone = '';
  String email = '';

  getUserData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: user.uid)
        .get();
    if (res.docs.isNotEmpty) {
      setState(() {
        userData =
            UserData.fromMap(res.docs.first.data() as Map<String, dynamic>);
        name = userData!.fname!;
        phone = userData!.phone!;
        img = userData!.image!;
        email = userData!.email!;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Settings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),

              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(
                        nam: '${userData!.fname}',
                        email: '${userData!.lname}',
                        id: '${userData!.id}',
                        img: '${userData!.image}',
                      ),
                    ),
                  );
                },
                leading: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage('${img}'))),
                ),
                title: Text(
                  '${name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: phone != null
                    ? Text(
                        '${phone}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    : Text(
                        '${email}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),

              //1st tile
              //
              // ListTile(
              //   leading: Container(
              //     height: 70.h,
              //     width: 70.w,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: Center(
              //       child: Icon(
              //         Icons.home,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Add Home',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.grey,
              //     size: 20,
              //   ),
              // ),
              // Divider(
              //   indent: 90,
              //   endIndent: 10,
              //   color: Colors.grey,
              // ),
              //
              // //2nd tile
              //
              // ListTile(
              //   leading: Container(
              //     height: 70.h,
              //     width: 70.w,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: Center(
              //       child: Icon(
              //         Icons.work,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Add Work',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.grey,
              //     size: 20,
              //   ),
              // ),
              // Divider(
              //   indent: 90,
              //   endIndent: 10,
              //   color: Colors.grey,
              // ),

              //3rd tile

              ListTile(
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
                leading: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ),
                title: Text(
                  'LogOut',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Divider(
                indent: 90,
                endIndent: 10,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    User? user = FirebaseAuth.instance.currentUser;
  }
}
