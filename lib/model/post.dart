class Post {
  String id;
  String? imagePath;
  String content;
  String postAccountId;
  DateTime? postTime;

  Post({
    required this.id,
    required this.imagePath,
    required this.content,
    required this.postAccountId,
    required this.postTime,
  });
}
