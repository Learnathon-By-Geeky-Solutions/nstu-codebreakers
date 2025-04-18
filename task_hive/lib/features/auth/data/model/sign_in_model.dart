import '../../domain/entity/user_entity.dart';

class SignInModel {
  String? email;
  String? name;
  int? id;

  SignInModel(this.email, this.name, this.id);

  SignInModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? 'No email';
    name = json['full_name'] ?? 'No name';
    id = json['id'] ?? 0;
  }
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      name: name,
      id: id,
    );
  }
}
