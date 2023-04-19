import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_time_tracker/core/application/constants/custom_toasts.dart';
import 'package:task_time_tracker/core/domain/entities/Users/IUserRepository.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  Future<CustomUser?> getCurrentUser() async {
    if (auth.currentUser != null) {
      var user = await _firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .withConverter<CustomUser>(
              fromFirestore: (snapshot, _) =>
                  CustomUser.fromJson(snapshot.data()!),
              toFirestore: (customUser, _) => customUser.toJson())
          .get();
      return user.data();
    } else {
      return null;
    }
  }

  Future<bool> updateUser(CustomUser user) async {
    try {
      _firestore.collection('users').doc(user.id).update(user.toJson());
      CustomToasts.successMessage(LocaleKeys.user_updated_successfully.tr());
      return true;
    } catch (e) {
      CustomToasts.errorMessage(e.toString());
      return false;
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
  registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendRegisterEmail();
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'displayName': name,
        'email': email,
        'id': userCredential.user!.uid,
        'emailVerified': userCredential.user!.emailVerified,
      });
      CustomToasts.successMessage(LocaleKeys.user_registered_successfully.tr());

      await auth.signOut();

      return CustomUser(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          emailVerified: userCredential.user!.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomToasts.errorMessage(LocaleKeys.password_is_too_weak.tr());
      } else if (e.code == 'email-already-in-use') {
        CustomToasts.errorMessage(LocaleKeys.email_already_in_use.tr());
      }
    } catch (e) {
      CustomToasts.errorMessage(e.toString());
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
      CustomToasts.successMessage(LocaleKeys.user_logged_in_successfully.tr());
      return getCurrentUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await CustomToasts.errorMessage(LocaleKeys.user_not_found.tr());
      } else if (e.code == 'wrong-password') {
        await CustomToasts.errorMessage(LocaleKeys.wrong_password.tr());
      } else if (e.code == 'user-disabled') {
        await CustomToasts.errorMessage(LocaleKeys.user_disabled.tr());
      } else if (e.code == 'email-not-verified') {
        await CustomToasts.errorMessage(LocaleKeys.email_not_verified.tr());
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
      await CustomToasts.successMessage(LocaleKeys.user_deleted_successfully.tr());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await CustomToasts.errorMessage(LocaleKeys.requires_recent_login.tr());
      }
    }
  }

 
}
