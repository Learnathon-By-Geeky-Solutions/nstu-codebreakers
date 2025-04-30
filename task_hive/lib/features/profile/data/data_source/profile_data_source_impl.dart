import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_hive/features/profile/data/data_source/profile_data_source.dart';

import '../../../../core/di/di.dart';
import '../../../../core/services/auth_service/auth_service.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final supabaseClient = getIt<AuthService>().getSupabaseClient();
  @override
  Future<Map<String, dynamic>> getProfileInfo(int userId) async {
    try {
      final response = await supabaseClient
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();
      if (response == null) {
        throw Exception('User not found');
      }
      return response;
    } catch (e) {
      throw Exception('Error fetching profile info: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfileInfo(
      Map<String, dynamic> profileInfo) async {
    try {
      final response = await supabaseClient
          .from('users')
          .update(profileInfo)
          .eq('id', profileInfo['id']);
      return response;
    } catch (e) {
      throw Exception('Error updating profile info: $e');
    }
  }
}
