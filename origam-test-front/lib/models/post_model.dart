class Post {
  final int id;
  final String title;
  final String userName;
  final String userImage;
  final String timestamp;

  Post({
    required this.id,
    required this.title,
    required this.userName,
    required this.userImage,
    required this.timestamp,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      userName: json['userName'],
      userImage: json['userImage'],
      timestamp: json['timestamp'],
    );
  }
}


