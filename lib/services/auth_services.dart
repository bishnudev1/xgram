
import 'dart:developer';

import 'package:xgram/models/user.dart';

class AuthServices{
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    log("Login has been successfully !");
    log("Email: $email" "password: $password");
    return User();
  }
}