import 'package:task_hive/features/auth/domain/entity/user_entity.dart';

class SignInModel {
  String? email;
  String? name;

  SignInModel(this.email, this.name);

  SignInModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? 'No email';
    name = json['full_name'] ?? 'No name';
  }
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      name: name,
    );
  }
}
