import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 12, top: 5),
                child: Row(
                  children: [
                    Text(
                      'Enter Mobile Number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                child: SizedBox(
                  width: 340.w,
                  child: IntlPhoneField(
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                        ),
                      ),
                    ),
                    initialCountryCode: 'PK',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {},
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Button(name: 'Continue', width: 320.w, onTap: () {}),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1.h,
                    width: 140.w,
                    color: Colors.black26,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 1.h,
                    width: 140.w,
                    color: Colors.black26,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () async {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              SizedBox(
                height: 20.h,
              ),
              SignInButton(
                Buttons.Facebook,
                text: "Sign in with Google",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
