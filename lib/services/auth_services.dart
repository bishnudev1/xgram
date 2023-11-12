import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:xgram/models/user.dart' as UserModel;

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel.User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final data = {
        'name': result.user?.displayName,
        'email': result.user?.email,
        'password': '', // Avoid storing the password in plain text
        'phone': '', // Get this data from the user profile if available
        'address': '', // Get this data from the user profile if available
        'city': '', // Get this data from the user profile if available
        'state': '', // Get this data from the user profile if available
        'country': '', // Get this data from the user profile if available
        'pincode': '', // Get this data from the user profile if available
        'uid': result.user?.uid,
      };
      return UserModel.User.fromMap(data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserModel.User?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final data = {
        'name': result.user?.displayName,
        'email': result.user?.email,
        'password': '', // Avoid storing the password in plain text
        'phone': '', // Get this data from the user profile if available
        'address': '', // Get this data from the user profile if available
        'city': '', // Get this data from the user profile if available
        'state': '', // Get this data from the user profile if available
        'country': '', // Get this data from the user profile if available
        'pincode': '', // Get this data from the user profile if available
        'uid': result.user?.uid,
      };
      return UserModel.User.fromMap(data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  getUser() async {
    try {
      final currentUser = _auth.currentUser;
      return currentUser;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
