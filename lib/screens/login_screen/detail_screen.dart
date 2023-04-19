import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScren extends StatefulWidget {
  const DetailScren({super.key});

  @override
  State<DetailScren> createState() => _DetailScrenState();
}

class _DetailScrenState extends State<DetailScren> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'What\'s your name?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Let us know how to properly adress you',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
