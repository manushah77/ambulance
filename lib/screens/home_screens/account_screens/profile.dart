import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/home_screens/account_screens/account.dart';
import 'package:embulance/screens/home_screens/home.dart';
import 'package:embulance/screens/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user_data.dart';
import '../../widgets/custom_text_field.dart';

class UserProfile extends StatefulWidget {
  String? nam;
  String? img;
  String? phn;
  String? email;
  String? id;

  UserProfile({
    this.img,
    this.email,
    this.nam,
    this.phn,
    this.id,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameC = TextEditingController();
  TextEditingController phnC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();


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
            'User Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 170.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('${widget.img}'), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'First Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: widget.nam,
                    validate: true,
                    controller: nameC,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: widget.email!,
                    validate: true,
                    controller: emailC,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),

                SizedBox(
                  height: 100.h,
                ),
                Button(
                  name: 'Update',
                  width: 280.w,
                  onTap: () async{
                    if(_formKey.currentState!.validate())
                      {
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(widget.id)
                            .update({
                          "firstName": nameC.text,
                          "lastName": emailC.text,
                        });

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                          ),
                        );
                      }

                  },
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
