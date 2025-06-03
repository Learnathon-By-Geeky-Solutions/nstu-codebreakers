import 'dart:io' show File;

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
      // First update the user data
      await supabaseClient
          .from('users')
          .update(profileInfo)
          .eq('id', profileInfo['id']);

      // Then fetch the updated user data
      final response = await supabaseClient
          .from('users')
          .select()
          .eq('id', profileInfo['id'])
          .maybeSingle();

      if (response == null) {
        throw Exception('Failed to fetch updated user data');
      }

      return response;
    } catch (e) {
      throw Exception('Error updating profile info: $e');
    }
  }

  @override
  Future<String> uploadProfileImage(String filePath) async {
    final storage = supabaseClient.storage.from('attachments');
    final fileName = filePath.split('/').last;
    try {
      final files = await storage.list(path: '');
      final exists = files.any((file) => file.name == fileName);

      if (exists) {
        return storage.getPublicUrl(fileName);
      }

      final file = File(filePath);

      await storage.upload(fileName, file);

      return storage.getPublicUrl(fileName);
    } catch (error) {
      throw Exception('Failed to upload profile image: $error');
    }
  }
}
