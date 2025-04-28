import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
    test(
        'should emit [FetchTaskLoadingState, FetchTaskSuccessState] when successful',
        () {
      when(() => mockFetchTaskUseCase.call(1))
          .thenAnswer((_) async => Left(testTask));

      fetchTaskCubit.fetchTask(1);

      expect(
        fetchTaskCubit.stream,
        emitsInOrder([
          isA<FetchTaskLoadingState>(),
          isA<FetchTaskSuccessState>().having(
            (state) => state.task,
            'task',
            testTask,
          ),
        ]),
      );
    });

    test('should emit [FetchTaskLoadingState, FetchTaskErrorState] when failed',
        () {
      final failure = Failure('Failed to fetch task');
      when(() => mockFetchTaskUseCase.call(1))
          .thenAnswer((_) async => Right(failure));

      fetchTaskCubit.fetchTask(1);

      expect(
        fetchTaskCubit.stream,
        emitsInOrder([
          isA<FetchTaskLoadingState>(),
          isA<FetchTaskErrorState>().having(
            (state) => state.failure,
            'failure',
            failure,
          ),
        ]),
      );
    });

    test(
        'should emit [FetchTaskLoadingState, FetchTaskErrorState] when exception occurs',
        () {
      when(() => mockFetchTaskUseCase.call(1))
          .thenThrow(Exception('Network error'));

      fetchTaskCubit.fetchTask(1);

      expect(
        fetchTaskCubit.stream,
        emitsInOrder([
          isA<FetchTaskLoadingState>(),
          isA<FetchTaskErrorState>().having(
            (state) => state.failure.message,
            'failure message',
            'Failed to fetch task',
          ),
        ]),
      );
    });
  });
}
