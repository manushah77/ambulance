import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  String name;
  double width;
  Function onTap;
  Button({required this.name, required this.width, required this.onTap});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.onTap();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        widget.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      height: 50.h,
      minWidth: widget.width,
      color: Colors.black,
    );
  }
}
