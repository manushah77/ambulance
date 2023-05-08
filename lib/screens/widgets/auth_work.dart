import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWork {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

//for user

  static Future<void> createUser() async {
    final chatUser = UserData(
        id: user.uid,
        fname: user.displayName.toString(),
        lname: user.displayName.toString(),
        phone: '',
        email: user.email.toString(),
        image: 'https://cdn-icons-png.flaticon.com/512/1430/1430453.png',
        latituelocation:  0.0,
        longitudelocation:  0.0,
        pushToken: '');

    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(chatUser.toMap());
  }

  //for driver google

  static Future<void> createDriver() async {
    final chatUser = UserData(
        id: user.uid,
        fname: user.displayName.toString(),
        lname: user.displayName.toString(),
        phone: '',
        email: user.email.toString(),
        image: 'https://cdn.iconscout.com/icon/free/png-256/free-ambulance-driver-2349770-1955457.png',
        latituelocation:  0.0,
        longitudelocation:  0.0,
        pushToken: '');

    return await firestore
        .collection('Driver')
        .doc(user.uid)
        .set(chatUser.toMap());
  }

  //for phone user

  static Future<void> createUserPhone() async {
    final dataUser = UserData(
        id: user.uid,
        fname: user.displayName.toString(),
        lname: user.displayName.toString(),
        phone: user.phoneNumber.toString(),
        email: user.email.toString(),
        latituelocation:  0.0,
        longitudelocation:  0.0,
        image: 'https://cdn-icons-png.flaticon.com/512/1430/1430453.png',
        pushToken: '');

    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(dataUser.toMap());
  }

  //for driver phone

  static Future<void> createDriverUserPhone() async {
    final dataUser = UserData(
        id: user.uid,
        fname: user.displayName.toString(),
        lname: user.displayName.toString(),
        phone: user.phoneNumber.toString(),
        email: user.email.toString(),
        image: 'https://cdn.iconscout.com/icon/free/png-256/free-ambulance-driver-2349770-1955457.png',
        latituelocation:  0.0,
        longitudelocation:  0.0,
        pushToken: '');

    return await firestore
        .collection('Driver')
        .doc(user.uid)
        .set(dataUser.toMap());
  }

  // for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('Driver').doc(user.uid).get()).exists;
  }
}
