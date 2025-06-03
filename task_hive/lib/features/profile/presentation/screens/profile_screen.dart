import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_hive/core/base/app_data/app_data.dart';
import 'package:task_hive/core/base/cubit/base_cubit.dart';
import 'package:task_hive/core/navigation/routes.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';
import 'package:task_hive/features/profile/domain/entity/profile_info.dart';
import 'package:task_hive/features/profile/presentation/cubits/profile_fetch_cubit.dart';
import 'package:task_hive/features/profile/presentation/cubits/profile_fetch_state.dart';

import '../../../../core/di/di.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntity? userData;

  const ProfileScreen({super.key, this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ProfileFetchCubit _profileCubit = getIt<ProfileFetchCubit>();
  final AppData _appData = getIt<AppData>();

  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;
  bool _isEditingName = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _profileCubit.fetchProfile(_appData.userId ?? 0);
  }

  Future<void> _logout() async {
    await getIt<AuthService>().getAuthClient().signOut();

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    if (mounted) context.go(MyRoutes.signInRoute);
  }

  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _hasChanges = true;
      });
    }
  }

  void _submitChanges() {
    final profile = ProfileInfo(
      id: _appData.userId,
      name: _nameController.text.trim(),
      url: _selectedImage?.path,
    );

    _profileCubit.editProfile(profile);

    setState(() {
      _selectedImage = null;
      _hasChanges = false;
      _isEditingName = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userData;

    final ImageProvider defaultImage = const NetworkImage(
      'https://thumbs.dreamstime.com/b/blank-grey-scale-profile-picture-placeholder-suitable-representing-user-avatar-contact-generic-style-short-hair-335067558.jpg',
    );

    var profileImage = user?.profilePictureUrl?.isNotEmpty == true
        ? NetworkImage(user!.profilePictureUrl!)
        : defaultImage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      floatingActionButton: (_hasChanges || _isEditingName)
          ? FloatingActionButton(
              onPressed: () => _submitChanges(),
              child: const Icon(Icons.done),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileFetchCubit, ProfileFetchState>(
          bloc: _profileCubit,
          builder: (context, state) {
            if (state is ProfileFetchLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileFetchError) {
              return Center(child: Text('Error:   ${state.error}'));
            }

            if (state is ProfileFetchSuccess) {
              final data = state.userData;
              _nameController.text = data.name ?? '';
              if (state.userData.url != null) {
                profileImage = NetworkImage(state.userData.url!);
              }

              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _selectedImage != null
                            ? FileImage(File(_selectedImage!.path))
                            : profileImage,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(Icons.edit,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _nameController,
                    readOnly: !_isEditingName,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: !_isEditingName
                            ? const Icon(Icons.edit)
                            : const SizedBox.shrink(),
                        onPressed: () {
                          setState(() {
                            _isEditingName = !_isEditingName;
                            _hasChanges = true;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildEmailCard(data.email ?? 'No email'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      getIt<BaseCubit>().toggleTheme();
                    },
                    child: const Text('Change theme mood'),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
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

  Widget _buildEmailCard(String email) {
    return Container(
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
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(email, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
