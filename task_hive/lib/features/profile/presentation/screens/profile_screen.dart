import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/navigation/routes.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';

import '../../../../core/di/di.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntity? userData;
  const ProfileScreen({super.key, this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout() async {
    await getIt<AuthService>().getAuthClient().signOut();
    if (mounted) {
      context.go(MyRoutes.signInRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/b/blank-grey-scale-profile-picture-placeholder-suitable-representing-user-avatar-contact-generic-style-short-hair-335067558.jpg',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.userData?.name ?? 'User Name',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.userData?.email ?? 'user@example.com',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
