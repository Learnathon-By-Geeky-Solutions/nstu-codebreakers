import 'package:task_hive/core/base/model/base_model.dart';
import '../../domain/entity/profile_info.dart';

class ProfileModel extends BaseModel<ProfileInfo> {
  String? name;
  String? email;
  String? url;
  ProfileModel({
    this.name,
    this.email,
    this.url,
  });
  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['full_name'];
    email = json['email'];
    url = json['profile_picture'];
  }
  @override
  toEntity() {
    return ProfileInfo(
      name: name,
      email: email,
      url: url,
    );
  }
}
