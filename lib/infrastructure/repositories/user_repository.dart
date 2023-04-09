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
  @override
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
  registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendRegisterEmail();
      Fluttertoast.showToast(
          msg: "User Registered Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      await auth.signOut();

      return CustomUser(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          emailVerified: userCredential.user!.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  sendRegisterEmail() async {
    await auth.currentUser!.sendEmailVerification();
  }

  @override
  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!userCredential.user!.emailVerified)
        // ignore: curly_braces_in_flow_control_structures
        throw FirebaseAuthException(code: 'email-not-verified');
      Fluttertoast.showToast(
          msg: "User Logged In Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
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
      } else if (e.code == 'user-disabled') {
        Fluttertoast.showToast(
            msg: "User has been disabled.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-not-verified') {
        Fluttertoast.showToast(
            msg: "Email not verified.",
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

  @override
  deleteAccount() async {
    try {
      await auth.currentUser!.delete();
      await signOut();
      Fluttertoast.showToast(
          msg: "User Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Fluttertoast.showToast(
            msg:
                "This operation is sensitive and requires recent authentication. Log in again before retrying this request.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
