import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';

abstract class IUserRepository {
  signInWithEmailAndPassword(String email, String password);

  Future<bool> signOut();

  registerWithEmailAndPassword(String email, String password, String name);

  bool IsLoggedIn();
  Future<CustomUser?> getCurrentUser();

  sendRegisterEmail();
  deleteAccount();
}
