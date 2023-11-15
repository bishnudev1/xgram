import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xgram/models/user.dart';

import '../services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  User? _fireUser;
  User? get fireUser => _fireUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final authServices = AuthServices();

  Future<void> login(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await authServices.login(email, password);
      if (_user == null) {
        _isLoading = false;
        notifyListeners();
        log('Login failed');
        return;
      } else {
        log('Login successful');
        Navigator.pushNamedAndRemoveUntil(
            context, '/profile', (route) => false);
      }
    } catch (e) {
      log(e.toString());
      _isLoading = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await authServices.register(email, password);
      if (_user == null) {
        _isLoading = false;
        notifyListeners();
        log('Register failed');
        return;
      } else {
        log('REgister successful');
        Navigator.pushNamedAndRemoveUntil(
            context, '/profile', (route) => false);
      }
    } catch (e) {
      log(e.toString());
      _isLoading = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

Future<void> getUserData() async {
  try {
    final resp = await authServices.getUser();
    log("Email: ${resp.email}");
    _fireUser = resp;
    notifyListeners();
    //return UserModel.fromMap(resp); // Assuming resp is a Map<String, dynamic>
  } catch (e) {
    log(e.toString());
    _fireUser = null;
    notifyListeners();
    //return UserModel(); // Return a default user or handle the error accordingly
  }
}




  navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  navigateToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
