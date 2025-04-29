import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/features/home/domain/entities/project_entity.dart';
import 'package:task_hive/features/home/domain/use_cases/home_use_cases.dart';
import 'package:task_hive/features/home/presentation/cubits/fetch_projects/fetch_projects_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hive/features/home/presentation/cubits/fetch_projects/fetch_projects_state.dart';

class MockFetchProjectsUseCase extends Mock implements FetchProjectsUseCase {}

void main() {
  late FetchProjectsCubit fetchProjectsCubit;
  late MockFetchProjectsUseCase mockFetchProjectsUseCase;

  setUp(() {
    mockFetchProjectsUseCase = MockFetchProjectsUseCase();
    fetchProjectsCubit = FetchProjectsCubit(mockFetchProjectsUseCase);
  });

  tearDown(() {
    fetchProjectsCubit.close();
  });

  test('initial state should be FetchProjectsInitial', () {
    expect(fetchProjectsCubit.state, isA<FetchProjectsInitial>());
  });

  group('fetchProjects', () {
    final userId = 1;
    final testProject = ProjectEntity(
      id: 1,
      name: 'Test Project 1',
      description: 'Description 1',
      createdAt: DateTime.now(),
    );

    blocTest<FetchProjectsCubit, FetchProjectsState>(
      'should emit [FetchProjectsLoading, FetchProjectsSuccess] when successful',
      build: () {
        when(() => mockFetchProjectsUseCase.call(userId)).thenAnswer(
            (_) async => Right<String, List<ProjectEntity?>>([testProject]));
        return fetchProjectsCubit;
      },
      act: (cubit) => cubit.fetchProjects(userId),
      expect: () => [
        isA<FetchProjectsLoading>(),
        isA<FetchProjectsSuccess>().having(
          (state) => state.projects,
          'projects',
          [testProject],
        ),
      ],
      verify: (_) {
        verify(() => mockFetchProjectsUseCase.call(userId)).called(1);
      },
    );

    blocTest<FetchProjectsCubit, FetchProjectsState>(
      'should emit [FetchProjectsLoading, FetchProjectsFailure] when failed',
      build: () {
        final failure = Failure('Failed to fetch projects');
        when(() => mockFetchProjectsUseCase.call(userId)).thenAnswer(
            (_) async => Left<String, List<ProjectEntity?>>(failure.message));
        return fetchProjectsCubit;
      },
      act: (cubit) => cubit.fetchProjects(userId),
      expect: () => [
        isA<FetchProjectsLoading>(),
        isA<FetchProjectsFailure>().having(
          (state) => state.failure,
          'failure',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Failed to fetch projects'),
        ),
      ],
    );

    blocTest<FetchProjectsCubit, FetchProjectsState>(
      'should emit [FetchProjectsLoading, FetchProjectsFailure] when exception occurs',
      build: () {
        when(() => mockFetchProjectsUseCase.call(userId))
            .thenThrow(Exception('Network error'));
        return fetchProjectsCubit;
      },
      act: (cubit) => cubit.fetchProjects(userId),
      expect: () => [
        isA<FetchProjectsLoading>(),
        isA<FetchProjectsFailure>().having(
          (state) => state.failure.message,
          'failure message',
          'Failed to fetch projects',
        ),
      ],
    );
  });
}
