import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:xgram/models/user.dart' as UserModel;

import '../services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  UserModel.User? _user;
  UserModel.User? get user => _user;

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

  getUserData() {
    final resp = authServices.getUser();
    _user = UserModel.User.fromMap(resp);
    notifyListeners();
  }

  navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  navigateToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
