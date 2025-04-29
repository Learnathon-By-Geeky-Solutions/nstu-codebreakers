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
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (name != null) map['full_name'] = name;
    if (email != null) map['email'] = email;
    if (password != null) map['password'] = password;
    if (profilePictureUrl != null) map['profile_picture'] = profilePictureUrl;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    return map;
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['full_name'],
      email: json['email'],
      password: json['password'],
      profilePictureUrl: json['profile_picture'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
