class Post {
  String id;
  String? imagePath;
  String postAccountId;
  DateTime? postTime;

  Post({
    required this.id,
    this.imagePath,
    required this.postAccountId,
    required this.postTime,
  });
}
