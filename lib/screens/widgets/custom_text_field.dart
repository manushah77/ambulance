import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  String? text;
  String? initiatext;
  final prefixIcon;
  final IconButton? suffixIcon;
  final bool? obsecureText;
  TextEditingController? controller;
  String? errorTxt;
  bool? validate;
  final maxlines;
  final minlines;
  final onchange;
  final keyboradType;
  bool? textedit;
  TextFieldWidget({
    Key? key,
    this.text,
    this.prefixIcon,
    this.obsecureText,
    this.suffixIcon,
    this.controller,
    this.errorTxt,
    this.keyboradType,
    this.maxlines,
    this.initiatext,
    this.minlines,
    this.onchange,
    this.validate,
    this.textedit,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obsecureText ?? false,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w200,
        color: Color(0xFF747688),
      ),
      initialValue: widget.initiatext,
      decoration: InputDecoration(
        //labelText: widget.text,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE4DFDF), width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE4DFDF), width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabled: widget.textedit ?? true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        hintText: widget.text,

        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w200,
          color: Color(0xFF747688),
        ),
      ),
      controller: widget.controller,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        if (widget.validate != null) {
          if (value == null || value.isEmpty) {
            return widget.errorTxt;
          }
          return null;
        }
      },
      onChanged: widget.onchange,
      keyboardType: widget.keyboradType,
      maxLines: widget.maxlines ?? 1,
      minLines: widget.minlines ?? 1,
    );
  }
}
