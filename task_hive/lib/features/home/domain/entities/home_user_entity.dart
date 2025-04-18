class HomePageUserEntity {
  int? userId;
  String? name;
  String? email;
  String? profilePictureUrl;

  HomePageUserEntity({
    this.name,
    this.email,
    this.profilePictureUrl,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'profile_picture': profilePictureUrl,
    };
  }

  HomePageUserEntity.fromJson(Map<String, dynamic> json)
      : userId = json['id'] ?? 0,
        name = json['full_name'] ?? 'No name',
        email = json['email'] ?? 'No email',
        profilePictureUrl = json['profile_picture'] ?? 'No profile picture';
}
