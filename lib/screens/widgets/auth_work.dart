import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embulance/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWork {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;

//crrat user

  static Future<void> createUser() async {
    final chatUser = UserData(
        id: user.uid,
        fname: user.displayName.toString(),
        lname: user.displayName.toString(),
        phone: '',
        email: user.email.toString(),
        image: '',
        pushToken: '');

    return await firestore
        .collection('user')
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
        // email: user.email.toString(),
        image: '',
        pushToken: '');

    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(dataUser.toMap());
  }

  // for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('user').doc(user.uid).get()).exists;
  }
}
