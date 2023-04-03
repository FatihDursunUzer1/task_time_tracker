import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';

abstract class IUserRepository {
  signInWithEmailAndPassword(String email, String password);

  Future<bool> signOut();

  Future<bool> registerWithEmailAndPassword(String email, String password);

  bool IsLoggedIn();
  //CustomUser? getCurrentUser();
}
