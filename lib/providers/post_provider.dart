import 'dart:developer';

import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/post_services.dart';
import '../utils/img_picker.dart';

class PostProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final postServices = PostServices(imagePick: ImagePick(), authServices: AuthServices());

  Future<void> addPost({required desc, required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await postServices.uploadPostToXgram(desc: desc);
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      log(e.toString());
      _isLoading = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}