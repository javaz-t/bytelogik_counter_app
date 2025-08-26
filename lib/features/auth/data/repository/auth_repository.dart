 import 'package:bytelogik_counter_app/features/auth/data/model/user_model.dart';
import 'package:bytelogik_counter_app/features/auth/data/services/firebase_auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
 

class AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepository(this._authService);

  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  UserModel? get currentUser => _authService.currentUser;

  Future<UserModel?> signIn(String email, String password) {
    return _authService.signInWithEmailAndPassword(email: email,password:  password);
  }

  Future<UserModel?> signUp(String email, String password) {
    return _authService.createUserWithEmailAndPassword(email: email,password:  password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }

    Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }
}