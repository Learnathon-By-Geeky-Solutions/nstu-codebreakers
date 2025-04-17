class UserEntity {
  String? name;
  String? email;
  String? password;
  String? profilePictureUrl;
  String? createdAt;
  String? updatedAt;

  UserEntity({
    this.name,
    this.email,
    this.password,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'profile_picture': profilePictureUrl,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }
}
