class UserModel {
  String? displayName;
  String? email;
  String? uid;

  UserModel({this.displayName, this.email, this.uid});

  UserModel.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    uid = data['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'uid': uid,
    };
  }
}
