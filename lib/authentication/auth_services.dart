import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register new user with email & password
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return "This email is already in use.";
        case 'invalid-email':
          return "Please enter a valid email address.";
        case 'weak-password':
          return "Password should be at least 6 characters.";
        default:
          return "Registration failed: ${e.message}";
      }
    } catch (e) {
      print("Unknown error during registration: $e");
      return "An unknown error occurred.";
    }
  }

  // Login user with email & password
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Please enter a valid email address.";
        case 'user-disabled':
          return "This account has been disabled.";
        case 'user-not-found':
          return "No account found with this email.";
        case 'wrong-password':
          return "Incorrect password. Please try again.";
        default:
          return "Login failed: ${e.message}";
      }
    } catch (e) {
      print("Unknown error during login: $e");
      return "An unknown error occurred.";
    }
  }

  // Send password reset email
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Please enter a valid email address.";
        case 'user-not-found':
          return "No account found with this email.";
        default:
          return "Password reset failed: ${e.message}";
      }
    } catch (e) {
      print("Unknown error during password reset: $e");
      return "An unknown error occurred.";
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}
