import 'package:bytelogik_counter_app/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    });
  }

  UserModel? get currentUser {
    final user = _auth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user != null ? UserModel.fromFirebaseUser(credential.user!) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user != null ? UserModel.fromFirebaseUser(credential.user!) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}