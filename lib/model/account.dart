class Account {
  String id;
  String name;
  String imagePath;
  String selfIntroduction;
  String userId;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.selfIntroduction,
    required this.userId,
    this.createdTime,
    this.updatedTime,
  });
}
