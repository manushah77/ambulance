import 'package:embulance/screens/login_screen/detail_screen.dart';
import 'package:embulance/screens/widgets/auth_work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:embulance/screens/home_screens/bottombar/bottom_nav_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../models/user_data.dart';
import '../widgets/alert_dialog_widget.dart';
import '../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  UserData? userdata;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                      controller: phoneController,
                      validator: (_) {
                        if (_ == null || _ == '') {
                          return 'Enter number';
                        }
                      },
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
                      onChanged: (value) {
                        phoneNo = value.number;
                      },
                      onCountryChanged: (country) {
                        // this.phoneNo = country.toString();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                    color: Colors.black,
                    name: 'Continue',
                    width: 320.w,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        verifyPhone();
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailScren(),
                      //   ),
                      // );
                    }),
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
                  onPressed: () async {
                    handlebuttonClick();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//auth code for google authentication

  Future<String> _googleSignIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.idToken != null) {
          // ignore: unused_local_variable
          final userCredential =
              await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
        }
      }
    } catch (e) {
      AlertDialogWidget.showSnakcbar(context, 'Check Connection');
    }
    return 'ok';
  }

//google auth button code

  handlebuttonClick() {
    AlertDialogWidget.showProgresbar(context);
    _googleSignIn().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        if ((await AuthWork.userExists())) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
        } else {
          await AuthWork.createUser().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          });
        }
      }
    });
  }

  //phone button code

  late String smssent, verificationId;
  late String phoneNo;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    } as PhoneCodeSent;
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+92$phoneNo",
      timeout: Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var errorController;
        return AlertDialog(
          title: Text('Provide OTP'),
          content: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            errorAnimationController: errorController, // Pas// s it here
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                this.smssent = value;
              });
            },
            appContext: context,
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                    );
                  } else {
                    Navigator.of(context).pop();
                    signIn(smssent);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        final User? users = FirebaseAuth.instance.currentUser;
        AuthWork.createUserPhone();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DetailScren()),
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
