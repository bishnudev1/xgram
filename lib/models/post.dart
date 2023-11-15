class Post {
  final String title;
  final String imageUrl;
  final String caption;
  final Map<String, dynamic> user; // Assuming 'user' is a map

  Post({
    required this.title,
    required this.caption,
    required this.imageUrl,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      caption: json['caption'],
      imageUrl: json['imageUrl'],
      user: json['user'], // Assuming 'user' is a map in the Firestore data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'caption': caption,
      'imageUrl': imageUrl,
      'user': user,
    };
  }
}
