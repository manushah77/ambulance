import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:embulance/models/admin_model.dart';
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
  TextEditingController carModelC = TextEditingController();
  TextEditingController idNumberC = TextEditingController();

  String dropdownValue = 'APV';
  String dropdownValueTwo = 'AC';



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
                  AdminData userdata = AdminData(
                    id: user.uid,
                    fname: fnameC.text.toString(),
                    lname: lnameC.text.toString(),
                    phone: user.phoneNumber.toString(),
                    email: user.email,
                    latituelocation: 0.0,
                    longitudelocation: 0.0,
                    image: 'https://cdn.iconscout.com/icon/free/png-256/free-ambulance-driver-2349770-1955457.png',
                    pushToken: '',

                    carDetail: dropdownValueTwo,
                    carModel: carModelC.text.toString(),
                    carName: dropdownValue,
                    idCardNumber: idNumberC.text.toString(),

                  );
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
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: 'Enter Car Model and Number',
                    controller: carModelC,
                    validate: true,
                  ),
                ),  SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 330.w,
                  child: TextFieldWidget(
                    text: 'Driver NID Number',
                    controller: idNumberC,
                    validate: true,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    width: 330.w,
                    height: 60.h,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: <String>[
                          'HIGHESS',
                          'APV',
                          'XPV',
                          'FAW PV',
                          'CARWAN PV',
                        ]
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value as String;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50.h,
                          width: 160.h,
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          iconSize: 28,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),

                        menuItemStyleData: MenuItemStyleData(
                          height: 40.h,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    width: 330.w,
                    height: 60.h,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: <String>[
                          'AC',
                          'NON AC',

                        ]
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: dropdownValueTwo,
                        onChanged: (value) {
                          setState(() {
                            dropdownValueTwo = value as String;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50.h,
                          width: 160.h,
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          iconSize: 28,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),

                        menuItemStyleData: MenuItemStyleData(
                          height: 40.h,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
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
