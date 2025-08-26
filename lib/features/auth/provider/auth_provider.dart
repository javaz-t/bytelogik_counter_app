import 'package:bytelogik_counter_app/features/auth/data/model/user_model.dart';
import 'package:bytelogik_counter_app/features/auth/data/repository/auth_repository.dart';
import 'package:bytelogik_counter_app/features/auth/data/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.read(firebaseAuthServiceProvider);
  return AuthRepository(authService);
});

final authStateProvider = StreamProvider<UserModel?>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(authRepository);
});

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.signIn(email, password);
      state = AsyncValue.data(user);
    } on FirebaseAuthException catch (e) {
       state = AsyncValue.error(_mapFirebaseAuthError(e), StackTrace.current);
    } catch (e){
            state = AsyncValue.error("Unexpected error: $e", StackTrace.current);

    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.signUp(email, password);
      state = AsyncValue.data(user);
     } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_mapFirebaseAuthError(e), StackTrace.current);
    } catch (e){
            state = AsyncValue.error("Unexpected error: $e", StackTrace.current);

    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signOut();
      state = const AsyncValue.data(null);
     } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_mapFirebaseAuthError(e), StackTrace.current);
    } catch (e){
            state = AsyncValue.error("Unexpected error: $e", StackTrace.current);

    }
  }

   String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "Email does not exist. Please sign up.";
      case 'wrong-password':
        return "Incorrect password. Try again.";
      case 'invalid-email':
        return "Invalid email format.";
      case 'email-already-in-use':
        return "This email is already registered. Try logging in.";
      case 'invalid-credential':
        return "Invalid or expired credential. Please try again.";
      default:
        return "Something went wrong. Please try again later.";
    }
  }
}
