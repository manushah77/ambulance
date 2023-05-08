import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/models/user_data.dart';
import 'package:embulance/screens/admin_home_screens/bottombar/admin_bottom_nav_bar.dart';
import 'package:embulance/screens/home_screens/bottombar/bottom_nav_bar.dart';
import 'package:embulance/screens/widgets/auth_work.dart';
import 'package:embulance/screens/widgets/button.dart';
import 'package:embulance/screens/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDetailScren extends StatefulWidget {
  const AdminDetailScren({super.key});

  @override
  State<AdminDetailScren> createState() => _AdminDetailScrenState();
}

class _AdminDetailScrenState extends State<AdminDetailScren> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fnameC = TextEditingController();
  TextEditingController lnameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            trailing: Button(
              name: 'Finish',
              width: 50.w,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User user = auth.currentUser!;
                  UserData userdata = UserData(
                      id: user.uid,
                      fname: fnameC.text.toString(),
                      lname: lnameC.text.toString(),
                      phone: user.phoneNumber.toString(),
                      email: user.email,
                      latituelocation:  0.0,
                      longitudelocation: 0.0 ,
                      image: 'https://cdn.iconscout.com/icon/free/png-256/free-ambulance-driver-2349770-1955457.png',
                      pushToken: '');
                  return await FirebaseFirestore.instance
                      .collection('Driver')
                      .doc(user.uid)
                      .set(userdata.toMap())
                      .then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminBottomBar(),
                      ),
                    );
                  });
                }
              },
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'What\'s your name?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Let us know how to properly adress you',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: 'First Name',
                    controller: fnameC,
                    validate: true,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: 'Last Name',
                    controller: lnameC,
                    validate: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
