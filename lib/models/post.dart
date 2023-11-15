class Post {
  final String name;  
  final String title;
  final String imageUrl;
  final String caption;

  Post({required this.name, required this.title, required this.caption, required this.imageUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json["name"],
      title: json['title'],
      caption: json['caption'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'caption': caption,
      'imageUrl': imageUrl,
    };
  }
}
