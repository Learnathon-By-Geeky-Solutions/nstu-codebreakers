import 'package:dartz/dartz.dart';

import 'onboarding_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingRemoteDataSourceImp implements OnboardingRemoteDataSource {
  @override
  Future<Either<bool, String>> checkSignedInStatus() async {
    try {
      final session = Supabase.instance.client.auth.currentSession;
      return Left(session != null);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
