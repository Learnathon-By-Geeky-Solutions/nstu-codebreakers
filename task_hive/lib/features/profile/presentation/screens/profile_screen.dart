import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/navigation/router_config.dart';
import 'package:task_hive/core/navigation/routes.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';

import '../../../../core/di/di.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/b/blank-grey-scale-profile-picture-placeholder-suitable-representing-user-avatar-contact-generic-style-short-hair-335067558.jpg',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'User Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'user@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await getIt<AuthService>().getAuthClient().signOut();
                  context.go(MyRoutes.signInRoute);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
