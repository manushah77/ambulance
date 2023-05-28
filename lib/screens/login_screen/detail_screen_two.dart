import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/user_data.dart';
import '../admin_home_screens/bottombar/admin_bottom_nav_bar.dart';
import '../home_screens/bottombar/bottom_nav_bar.dart';
import '../widgets/button.dart';
import '../widgets/custom_text_field.dart';

class DetailScreenTwo extends StatefulWidget {
  const DetailScreenTwo({Key? key}) : super(key: key);

  @override
  State<DetailScreenTwo> createState() => _DetailScreenTwoState();
}

class _DetailScreenTwoState extends State<DetailScreenTwo> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fnumberC = TextEditingController();
  TextEditingController diseaseC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fname: user.displayName.toString(),
                    lname: user.displayName.toString(),
                    phone: fnumberC.text,
                    email: user.email,
                    latituelocation:  0.0,
                    longitudelocation: 0.0 ,
                    image: 'https://cdn.iconscout.com/icon/free/png-256/free-ambulance-driver-2349770-1955457.png',
                    pushToken: '',
                  disease: diseaseC.text,

                );
                return await FirebaseFirestore.instance
                    .collection('user')
                    .doc(user.uid)
                    .set(userdata.toMap())
                    .then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBar(),
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
              SizedBox(
                height: 100.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Enter Phone Number for Further Process',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: 'Phone Number',
                    controller: fnumberC,
                    validate: true,
                    keyboradType: TextInputType.number,
                  ),
                ),
              ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: SizedBox(
              width: 330.w,
              child: TextFieldWidget(
                text: 'Describe Disease',
                controller: diseaseC,
                validate: true,
              ),
            ),
          ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
