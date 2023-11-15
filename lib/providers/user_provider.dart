import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xgram/models/user.dart';

import '../services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  // User? _fireUser;
  // User? get fireUser => _fireUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final authServices = AuthServices();

  Future<void> login(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final resp = await authServices.login(email, password);
      if (resp == null) {
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

  Future<void> register(String email, String password, BuildContext context,
      String displayName) async {
    _isLoading = true;
    notifyListeners();
    try {
      final resp = await authServices.register(
          email: email, password: password, displayName: displayName);
      if (resp == false) {
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
         notifyListeners();
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
      final profile = await authServices.getUser();
      _user = profile;
    } catch (e) {
      log(e.toString());
      _user = null;
      notifyListeners();
    }
  }

  navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  navigateToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  Future<void> logout(BuildContext context) async {
    try {
      await authServices.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      log(e.toString());
    }
  }
}
