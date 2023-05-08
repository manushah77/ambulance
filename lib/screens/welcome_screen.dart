import 'package:embulance/screens/admin_login_screen/admin_login_screen.dart';
import 'package:embulance/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_screens/map_page.dart';
import 'login_screen/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'WELCOME',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'We Serve You',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height:  230.h,
              ),
              Button(
                  color: Colors.black,
                  name: 'Sign Up As a Patient',
                  width: 300.w,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }),
              SizedBox(
                height: 10.h,
              ),
              Button(
                  color: Colors.black,
                  name: 'Sign Up As a Driver',
                  width: 300.w,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminLoginScreen(),
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
