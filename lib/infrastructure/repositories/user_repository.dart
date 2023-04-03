import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_time_tracker/core/domain/entities/Users/IUserRepository.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';

class UserRepository implements IUserRepository {
  UserRepository._privateConstructor();
  static UserRepository? _instance;
  static UserRepository get instance {
    _instance ??= UserRepository._privateConstructor();
    return _instance!;
  }

  static FirebaseAuth auth = FirebaseAuth.instance;

  /*@override
  bool IsLoggedIn() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  } */
  CustomUser? getCurrentUser() {
    if (auth.currentUser != null) {
      return CustomUser(
          id: auth.currentUser!.uid,
          email: auth.currentUser!.email!,
          emailVerified: auth.currentUser!.emailVerified);
    } else {
      return null;
    }
  }

  @override
  bool IsLoggedIn() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      return true;
    }).onError((error, stackTrace) {
      //show pop up
      print(error);
      return false;
    });
    return false;
  }

  @override
  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return CustomUser(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          emailVerified: userCredential.user!.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Future<bool> signOut() async {
    await auth.signOut();
    return true;
  }
}
