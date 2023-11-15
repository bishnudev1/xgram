import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:xgram/models/user.dart';
import 'package:xgram/utils/toast.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("users");

  bool get isSignedIn {
    return _auth.currentUser != null ? true : false;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final data = {
        'email': result.user?.email,
        'uid': result.user?.uid,
      };
      return UserModel.fromMap(data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

Future<bool> register(
    {required String email,
    required String password,
    required String displayName}) async {
  try {
    final value = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final data = {
      'displayName': displayName,
      'email': value.user?.email,
      'uid': value.user?.uid,
    };

    await _firestore.add(UserModel.fromMap(data).toMap());

    log("User Added Successfully");
    showToast("User Added Successfully");
    return true;
  } catch (e) {
    log(e.toString());
    showToast("Error in register Function: $e");
    return false;
  }
}


  Future<void> logout() async {
    await _auth.signOut();
  }

Future<UserModel?> getUser() async {
  log("Into getUser Function");
  try {
    final currentUser = _auth.currentUser;

    if (currentUser != null && currentUser.email != null) {
      final currentUserEmail = currentUser.email!;
      final res = await _firestore
          .where('email', isEqualTo: currentUserEmail)
          .get();

      if (res.docs.isNotEmpty) {
        final data = res.docs[0].data() as Map<String, dynamic>?;

        if (data != null) {
          log("Data: $data");
          return UserModel.fromMap(data);
        }
      }
    }
    return null;
  } catch (e) {
    log("Error Getting User in getUser Function: $e");
    return null;
  }
}


}
