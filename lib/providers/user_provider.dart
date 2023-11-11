import 'package:flutter/material.dart';
import 'package:xgram/models/user.dart';

import '../services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final authServices = AuthServices();

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      user = await authServices.login(email, password);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
