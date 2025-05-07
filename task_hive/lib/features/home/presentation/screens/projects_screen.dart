import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/app_extension.dart';
import '../../../../core/base/app_data/app_data.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../../domain/entities/home_user_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../cubits/create_project/create_project_cubit.dart';
import '../cubits/create_project/create_project_state.dart';
import '../cubits/fetch_projects/fetch_projects_cubit.dart';
import '../cubits/fetch_projects/fetch_projects_state.dart';
import '../cubits/fetch_user/fetch_user_cubit.dart';
import '../cubits/fetch_user/fetch_user_state.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _fetchProjectCubit = getIt.get<FetchProjectsCubit>();
  final _fetchUserCubit = getIt.get<FetchUserCubit>();
  final _createProjectCubit = getIt.get<CreateProjectCubit>();
  final _appData = getIt.get<AppData>();
  HomePageUserEntity? userData;

  @override
  void initState() {
    _fetchUserCubit.fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    _fetchProjectCubit.close();
    _fetchUserCubit.close();
    _createProjectCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFe0eafc), Color(0xFFcfdef3)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: SizedBox(
          height: 64,
          width: 64,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => CreateProjectBottomSheet(
                    createProjectCubit: _createProjectCubit,
                    userData: userData,
                    fetchProjectsCubit: _fetchProjectCubit,
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<FetchUserCubit, FetchUserState>(
                  bloc: _fetchUserCubit,
                  builder: (context, state) {
                    if (state is FetchUserLoading) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.blue));
                    } else if (state is FetchUserSuccess) {
                      _fetchProjectCubit
                          .fetchProjects(state.userData.userId ?? 0);
                      userData = state.userData;
                      _appData.userEmail = state.userData.email;
                      _appData.userName = state.userData.name;
                      _appData.userId = state.userData.userId;
                      return _HeaderSection(user: state.userData);
                    } else if (state is FetchUserFailed) {
                      return Text('Error: ${state.error}');
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Recent Projects',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: Colors.white.withOpacity(0.7),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          BlocBuilder<FetchProjectsCubit, FetchProjectsState>(
                            bloc: _fetchProjectCubit,
                            builder: (context, state) {
                              if (state is FetchProjectsLoading) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: CircularProgressIndicator(
                                        color: Colors.blue),
                                  ),
                                );
                              } else if (state is FetchProjectsSuccess) {
                                if (state.projects.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Text('No projects found',
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  );
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.projects.length,
                                  separatorBuilder: (context, idx) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final project = state.projects[index];
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                      child: GestureDetector(
                                        onTap: () {
                                          _appData.currentProjectId =
                                              project?.id ?? 0;
                                          context.push(
                                            '${MyRoutes.home}/${MyRoutes.projectDetails}',
                                          );
                                        },
                                        child: RecentProjectsCard(
                                            project: project),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is FetchProjectsFailure) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Text('Error: ${state.failure}',
                                      style:
                                          const TextStyle(color: Colors.red)),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final HomePageUserEntity user;
  const _HeaderSection({required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF6a11cb),
          child: Text(
            (user.name?.isNotEmpty ?? false)
                ? user.name![0].toUpperCase()
                : '?',
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,',
                style: textTheme.bodyLarge?.copyWith(color: Colors.black54)),
            Text(
              user.name ?? 'Unknown',
              style: textTheme.titleLarge?.copyWith(
                color: const Color(0xFF2575fc),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RecentProjectsCard extends StatelessWidget {
  final ProjectEntity? project;
  const RecentProjectsCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 6,
      shadowColor: Colors.blue.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.account_balance,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project?.name ?? 'N/A',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project?.description ?? 'N/A',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateProjectBottomSheet extends StatefulWidget {
  final CreateProjectCubit? createProjectCubit;
  final FetchProjectsCubit? fetchProjectsCubit;
  final HomePageUserEntity? userData;
  const CreateProjectBottomSheet({
    super.key,
    this.createProjectCubit,
    this.userData,
    this.fetchProjectsCubit,
  });

  @override
  State<CreateProjectBottomSheet> createState() =>
      _CreateProjectBottomSheetState();
}

class _CreateProjectBottomSheetState extends State<CreateProjectBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 26.0,
        bottom: 26.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Create New Project',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please fill the input box';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please fill the input box';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final title = titleController.text.trim();
                    final description = descriptionController.text.trim();
                    widget.createProjectCubit?.createProject(
                      ProjectEntity(
                        name: title,
                        description: description,
                        createdBy: widget.userData?.userId ?? 0,
                      ),
                    );
                  }
                },
                child: BlocBuilder<CreateProjectCubit, CreateProjectState>(
                  bloc: widget.createProjectCubit,
                  builder: (context, state) {
                    if (state is CreateProjectLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    } else if (state is CreateProjectSuccess) {
                      widget.fetchProjectsCubit?.fetchProjects(
                        widget.userData?.userId ?? 0,
                      );
                      _showSnackBar(state.success.message);
                      Navigator.pop(context);
                    }
                    if (state is CreateProjectFailure) {
                      _showSnackBar(state.failure.message);
                    }
                    return const Text('Submit');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
}
