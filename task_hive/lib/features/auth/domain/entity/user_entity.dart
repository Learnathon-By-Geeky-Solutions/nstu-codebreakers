class UserEntity {
  int? id;
  String? name;
  String? email;
  String? password;
  String? profilePictureUrl;
  String? createdAt;
  String? updatedAt;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name ?? 'No name',
      'email': email ?? 'No email',
      'profile_picture': profilePictureUrl,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }

  static UserEntity fromJson(json) {
    return UserEntity(
      id: json['id'],
      name: json['full_name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
