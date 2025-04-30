import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_hive/core/base/app_data/app_data.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ProfileFetchCubit _profileFetchCubit = getIt<ProfileFetchCubit>();
  final AppData _appData = getIt<AppData>();
  final TextEditingController _nameController = TextEditingController();
  bool _isEditingName = false;

  Future<void> _logout() async {
    await getIt<AuthService>().getAuthClient().signOut();

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    if (mounted) {
      context.go(MyRoutes.signInRoute);
    }
  }

  @override
  void initState() {
    _profileFetchCubit.fetchProfile(_appData.userId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userData;
    final profileImage = user?.profilePictureUrl?.isNotEmpty == true
        ? NetworkImage(user!.profilePictureUrl!)
        : const NetworkImage(
            'https://thumbs.dreamstime.com/b/blank-grey-scale-profile-picture-placeholder-suitable-representing-user-avatar-contact-generic-style-short-hair-335067558.jpg',
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileFetchCubit, ProfileFetchState>(
          bloc: _profileFetchCubit,
          builder: (context, state) {
            if (state is ProfileFetchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFetchError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is ProfileFetchSuccess) {
              final userData = state.userData;
              _nameController.text = userData.name ?? '';
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImage,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            // TODO: Implement image upload logic
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          enabled: _isEditingName,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isEditingName ? Icons.save : Icons.edit),
                              onPressed: () {
                                setState(() {
                                  if (_isEditingName) {
                                    // TODO: Implement save name logic
                                  }
                                  _isEditingName = !_isEditingName;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              userData.email ?? 'No email',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
