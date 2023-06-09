import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/screens/home_screens/account_screens/account.dart';
import 'package:embulance/screens/home_screens/bottombar/bottom_nav_bar.dart';
import 'package:embulance/screens/home_screens/home.dart';
import 'package:embulance/screens/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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


  final picker = ImagePicker();
  File? _image;
  Future pickImage() async {
    var pickImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        _image = File(pickImage.path);
      } else {
        print('no image selected');
      }
    });
  }

  Future<String> uploadFile(File _image) async {
    String downloadURL;
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("post_$postId.png");
    await ref.putFile(_image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
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
                InkWell(
                  onTap: () async {
                    pickImage().then((value) async {
                      String url = await uploadFile(_image!);
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(widget.id)
                          .update({
                        "image": url,
                      });
                      uploadFile(_image!).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ),
                        );
                        Fluttertoast.showToast(
                            msg: "Profile Picture Updated ..!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    });
                  },
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2, color: const Color(0xFFE4DFDF)),
                      image: DecorationImage(
                        image: widget.img != null
                            ? NetworkImage( widget.img.toString())
                            : NetworkImage(
                            '${widget.img}'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
