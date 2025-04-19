import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/core/extensions/app_extension.dart';

import '../../../../core/di/di.dart';
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
    HomePageUserEntity? _userData;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => CreateProjectBottomSheet(
                createProjectCubit: _createProjectCubit,
                userData: _userData,
                fetchProjectsCubit: _fetchProjectCubit,
              ),
            );
          },
          icon: Icon(Icons.add, color: colorScheme.surface),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<FetchUserCubit, FetchUserState>(
                    bloc: _fetchUserCubit,
                    builder: (context, state) {
                      if (state is FetchUserLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.blue,
                        );
                      } else if (state is FetchUserSuccess) {
                        _fetchProjectCubit.fetchProjects(
                            userId: state.userData.userId ?? 0);
                        _userData = state.userData;
                        // return Text(
                        //   'Welcome ${state.userData.name}',
                        //   style: textTheme.textxlRegular,
                        // );
                        return const SizedBox.shrink();
                      } else if (state is FetchUserFailed) {
                        return Text('Error: ${state.error}');
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Text(
                    'Recent Projects',
                    style: textTheme.textxlMedium
                        .copyWith(color: colorScheme.primary),
                  ),
                  Divider(
                    color: colorScheme.tertiary,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<FetchProjectsCubit, FetchProjectsState>(
                          bloc: _fetchProjectCubit,
                          builder: (context, state) {
                            if (state is FetchProjectsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            } else if (state is FetchProjectsSuccess) {
                              if (state.projects.isEmpty) {
                                return const Center(
                                  child: Text('No projects found'),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.projects.length,
                                itemBuilder: (context, index) {
                                  final project = state.projects[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: RecentProjectsCard(project: project),
                                  );
                                },
                              );
                            } else if (state is FetchProjectsFailed) {
                              return Text('Error: ${state.error}');
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Icon(
              Icons.account_balance,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project?.name ?? 'N/A',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  project?.description ?? 'N/A',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
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
                        userId: widget.userData?.userId ?? 0,
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

  ///show snackbar
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
