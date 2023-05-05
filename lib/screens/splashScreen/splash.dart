// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:async';

import 'package:embulance/screens/login_screen/login_screen.dart';
import 'package:embulance/screens/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_screens/bottombar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen(
      (user) {
        Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  FirebaseAuth.instance.currentUser != null
                      ? BottomBar()
                      : LoginScreen(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Button(
              color: Colors.black,
              name: 'Get Started',
              width: 320.w,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ), // Replace "HomeScreen()" with your app's home screen.
                );
              }),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Text(
                'Human Savior',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 45.h),
              Image.asset(
                'assets/images/aa.png',
                scale: 2.5,
                color: Colors.red,
              ),
              SizedBox(height: 45.h),
              Text(
                'Ready to Serve You',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 230.h),
            ],
          ),
        ),
      ),
    );
  }
}
