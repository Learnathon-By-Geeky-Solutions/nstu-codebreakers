import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
    final testProjects = [
      ProjectEntity(
        id: 1,
        name: 'Test Project 1',
        description: 'Description 1',
        createdAt: DateTime.now(),
      ),
      ProjectEntity(
        id: 2,
        name: 'Test Project 2',
        description: 'Description 2',
        createdAt: DateTime.now(),
      ),
    ];

    test(
        'should emit [FetchProjectsLoading, FetchProjectsSuccess] when successful',
        () {
      when(() => mockFetchProjectsUseCase.call(1))
          .thenAnswer((_) async => Left(testProjects));

      fetchProjectsCubit.fetchProjects(userId: 1);

      expect(
        fetchProjectsCubit.stream,
        emitsInOrder([
          isA<FetchProjectsLoading>(),
          isA<FetchProjectsSuccess>().having(
            (state) => state.projects,
            'projects',
            testProjects,
          ),
        ]),
      );
    });

    test('should emit [FetchProjectsLoading, FetchProjectsFailure] when failed',
        () {
      final errorMessage = 'Failed to fetch projects';
      when(() => mockFetchProjectsUseCase.call(1))
          .thenAnswer((_) async => Right(errorMessage));

      fetchProjectsCubit.fetchProjects(userId: 1);

      expect(
        fetchProjectsCubit.stream,
        emitsInOrder([
          isA<FetchProjectsLoading>(),
          isA<FetchProjectsFailed>().having(
            (state) => state.error,
            'failure',
            errorMessage,
          ),
        ]),
      );
    });

    test(
        'should emit [FetchProjectsLoading, FetchProjectsFailure] when exception occurs',
        () {
      when(() => mockFetchProjectsUseCase.call(1))
          .thenThrow(Exception('Network error'));

      fetchProjectsCubit.fetchProjects(userId: 1);

      expect(
        fetchProjectsCubit.stream,
        emitsInOrder([
          isA<FetchProjectsLoading>(),
          isA<FetchProjectsFailed>().having(
            (state) => state.error,
            'failure message',
            'Failed to fetch projects',
          ),
        ]),
      );
    });

    test('verifies fetch projects use case is called with correct user id', () {
      when(() => mockFetchProjectsUseCase.call(1))
          .thenAnswer((_) async => Left(testProjects));

      fetchProjectsCubit.fetchProjects(userId: 1);

      verify(() => mockFetchProjectsUseCase.call(1)).called(1);
    });
  });
}
