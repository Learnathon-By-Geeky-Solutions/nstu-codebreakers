import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/use_case/project_details_use_case.dart';
import 'package:task_hive/features/project_details/presentation/cubits/fetch_task/fetch_task_cubit.dart';
import 'package:dartz/dartz.dart';

class MockFetchTaskUseCase extends Mock implements FetchTaskUseCase {}

void main() {
  late FetchTaskCubit fetchTaskCubit;
  late MockFetchTaskUseCase mockFetchTaskUseCase;
  late TaskEntity testTask;

  setUp(() {
    mockFetchTaskUseCase = MockFetchTaskUseCase();
    fetchTaskCubit = FetchTaskCubit(mockFetchTaskUseCase);
    testTask = TaskEntity(
      taskId: 1,
      title: 'Test Task',
      description: 'Test Description',
      projectId: 1,
    );
  });

  tearDown(() {
    fetchTaskCubit.close();
  });

  test('initial state should be FetchTaskInitialState', () {
    expect(fetchTaskCubit.state, isA<FetchTaskInitialState>());
  });

  group('fetchTask', () {
    blocTest<FetchTaskCubit, FetchTaskState>(
      'should emit [FetchTaskLoadingState, FetchTaskSuccessState] when successful',
      build: () {
        when(() => mockFetchTaskUseCase.call(1))
            .thenAnswer((_) async => Right(testTask));
        return fetchTaskCubit;
      },
      act: (cubit) => cubit.fetchTask(1),
      expect: () => [
        isA<FetchTaskLoadingState>(),
        isA<FetchTaskSuccessState>().having(
          (state) => state.task,
          'task',
          testTask,
        ),
      ],
    );

    blocTest<FetchTaskCubit, FetchTaskState>(
      'should emit [FetchTaskLoadingState, FetchTaskErrorState] when failed',
      build: () {
        final failure = Failure('Failed to fetch task');
        when(() => mockFetchTaskUseCase.call(1))
            .thenAnswer((_) async => Left(failure));
        return fetchTaskCubit;
      },
      act: (cubit) => cubit.fetchTask(1),
      expect: () => [
        isA<FetchTaskLoadingState>(),
        isA<FetchTaskErrorState>().having(
          (state) => state.failure,
          'failure',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Failed to fetch task'),
        ),
      ],
    );

    blocTest<FetchTaskCubit, FetchTaskState>(
      'should emit [FetchTaskLoadingState, FetchTaskErrorState] when exception occurs',
      build: () {
        when(() => mockFetchTaskUseCase.call(1))
            .thenThrow(Exception('Network error'));
        return fetchTaskCubit;
      },
      act: (cubit) => cubit.fetchTask(1),
      expect: () => [
        isA<FetchTaskLoadingState>(),
        isA<FetchTaskErrorState>().having(
          (state) => state.failure.message,
          'failure message',
          'Failed to fetch task',
        ),
      ],
    );
  });
}
