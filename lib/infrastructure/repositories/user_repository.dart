import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  static FirebaseAuth auth = FirebaseAuth.instance;
  bool LoginWithFirebase(String email, String password) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => print(value.user!.email))
        .catchError((e) {
      throw e;
    });

    return true;
  }

  bool RegisterWithFirebase(String email, String password) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print(value.user!.email))
        .catchError((e) {
      throw e;
    });

    return true;
  }

  bool LogoutWithFirebase() {
    auth.signOut();
    return true;
  }

  bool IsLoggedIn() {
    return auth.currentUser != null;
  }
}
