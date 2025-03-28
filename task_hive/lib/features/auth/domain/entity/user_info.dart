class UserInfo {
  String? name;
  String? email;
  String? password;
  String? profilePictureUrl;
  String? createdAt;
  String? updatedAt;

  UserInfo({
    this.name,
    this.email,
    this.password,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profile_picture_url': profilePictureUrl,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }
}
