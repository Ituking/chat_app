class User {
  String name;
  String uid;
  String? imagePath;

  User({
    required this.name,
    required this.uid,
    String? imagePath,
  }) : imagePath = imagePath != '' ? imagePath : null;
}
