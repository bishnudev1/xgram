import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:xgram/utils/img_picker.dart';
import 'package:xgram/utils/toast.dart';

import '../models/post.dart';
import '../models/user.dart';
import 'auth_services.dart';

class PostServices {
  final ImagePick imagePick;
  final AuthServices authServices;

    UserModel? _user;

  PostServices({required this.imagePick, required this.authServices});

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("posts");

  final CollectionReference _firestore1 =
      FirebaseFirestore.instance.collection("users");

  Future<String?> uploadToFirebaseStorage(
      {required File image, required String fileName}) async {
    try {
      final ref = _storage.ref().child('posts').child(fileName);
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
      showToast("Error Uploading Image in uploadToFirebaseStorage Function");
      return null;
    }
  }

  Future<bool> uploadPostDesc(
      {required desc,
      required imgUrl,
      required name,
      required photoUrl}) async {
    try {
      final resp = await _firestore.add(Post(user: {
        "name": name,
        "photoUrl": photoUrl,
      }, title: desc, caption: desc, imageUrl: imgUrl)
          .toJson());
      log("RESP: $resp");
      return true;
    } catch (e) {
      log(e.toString());
      showToast("Error Uploading Post in uploadPostDesc Function");
      return false;
    }
  }


  Future<bool> uploadPostToXgram({required desc}) async {
    try {

      final profile = await authServices.getUser();

      if(profile == null){
        showToast("Please Login First");
        return false;
      }

      final imagePath = await imagePick.uploadedFile(desc: desc);

      if (imagePick.image == null) {
        showToast("Please add your image first");
        return false;
      } else {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final url = await uploadToFirebaseStorage(
            image: imagePath!, fileName: fileName);

        if (url == null) {
          showToast("Error Uploading Image");
          return false;
        } else {
          final resp = await uploadPostDesc(desc: desc, imgUrl: url, name: profile.displayName, photoUrl: profile.photoUrl);
          showToast("Post Uploaded Successfully");
          return true;
        }
      }
    } catch (e) {
      showToast("Error Uploading Post");
      return false;
    }
  }
}
