 import 'package:bytelogik_counter_app/features/auth/data/model/user_model.dart';
import 'package:bytelogik_counter_app/features/auth/data/services/firebase_auth_services.dart';
 

class AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepository(this._authService);

  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  UserModel? get currentUser => _authService.currentUser;

  Future<UserModel?> signIn(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future<UserModel?> signUp(String email, String password) {
    return _authService.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }
}