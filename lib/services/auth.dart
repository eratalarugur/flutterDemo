import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService() {}

  User? _userFromFirebase(User? user) {
    return user;
  }
  /// Auth Stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: mail, password: pass);
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        return 'Your account is disabled';
      }
      if (e.code == 'user-not-found') {
        return 'Please check your e-mail and try again';
      }
      if (e.code == 'wrong-password') {
        return 'Wrong password';
      }
      return null;
    } catch (e) {
      return 'Unknown error: ${e.toString()}';
    }
  }

  Future signUpWithEmailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email is already registered';
      }
      if (e.code == 'operation-not-allowed') {
        return 'This operation is disabled';
      }
      if (e.code == 'weak-password') {
        return 'Password is not secure enough';
      }
      return null;
    } catch (e) {
      return 'Unknown error:${e.toString()}';
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}