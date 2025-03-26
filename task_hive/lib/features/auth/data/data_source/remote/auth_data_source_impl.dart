import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final authClient = getIt<AuthService>().getAuthClient();

  @override
  Future<void> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(Map<String, dynamic> input) async {
    print('dbg calling');
    await Future.delayed(Duration(seconds: 1));
    return null;
    await authClient.signUp(
      email: input['email'],
      password: input['password'],
    );
  }

  @override
  Future<void> verifyOtp() {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
