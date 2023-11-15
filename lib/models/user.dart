class UserModel {
  String? displayName;
  String? email;
  late bool isVerified;
  late String photoUrl;

  UserModel({this.displayName, this.email, this.isVerified = false, this.photoUrl = ""});

  UserModel.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    isVerified = data['isVerified'] ?? false; // Use default value if not present
    photoUrl = data['photoUrl'] ?? ""; // Use default value if not present
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'isVerified': isVerified,
      'photoUrl': photoUrl,
    };
  }
}
