import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../cubits/fetch_projects/fetch_projects_cubit.dart';
import '../cubits/fetch_projects/fetch_projects_state.dart';
import '../cubits/fetch_user/fetch_user_cubit.dart';
import '../cubits/fetch_user/fetch_user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fetchProjectCubit = getIt.get<FetchProjectsCubit>();
  final _fetchUserCubit = getIt.get<FetchUserCubit>();
  @override
  void initState() {
    _fetchUserCubit.fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    _fetchProjectCubit.close();
    _fetchUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    return Text('Welcome ${state.userData.name}');
                  } else if (state is FetchUserFailed) {
                    return Text('Error: ${state.error}');
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<FetchProjectsCubit, FetchProjectsState>(
                      bloc: _fetchProjectCubit,
                      builder: (context, state) {
                        if (state is FetchProjectsLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        } else if (state is FetchProjectsSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.projects.length,
                            itemBuilder: (context, index) {
                              final project = state.projects[index];
                              return ListTile(
                                title: Text(project?.name ?? 'No Name'),
                                subtitle: Text(
                                    project?.description ?? 'No Description'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
