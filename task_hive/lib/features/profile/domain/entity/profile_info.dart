class ProfileInfo {
  int? id;
  String? name;
  String? email;
  String? url;

  ProfileInfo({
    this.id,
    this.name,
    this.email,
    this.url,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['full_name'] = name;
    if (email != null) map['email'] = email;
    if (url != null) map['profile_picture'] = url;
    return map;
  }
}
