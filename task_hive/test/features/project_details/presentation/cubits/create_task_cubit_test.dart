import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/use_case/project_details_use_case.dart';
import 'package:task_hive/features/project_details/presentation/cubits/create_task/create_task_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hive/features/project_details/presentation/cubits/create_task/create_task_state.dart';

class MockCreateTaskUseCase extends Mock implements CreateTaskUseCase {}

void main() {
  late CreateTaskCubit createTaskCubit;
  late MockCreateTaskUseCase mockCreateTaskUseCase;
  late TaskEntity testTask;

  setUp(() {
    mockCreateTaskUseCase = MockCreateTaskUseCase();
    createTaskCubit = CreateTaskCubit(mockCreateTaskUseCase);
    testTask = TaskEntity(
      title: 'Test Task',
      description: 'Test Description',
      projectId: 1,
    );
  });

  tearDown(() {
    createTaskCubit.close();
  });

  test('initial state should be CreateTaskInitialState', () {
    expect(createTaskCubit.state, isA<CreateTaskInitialState>());
  });

  group('createTask', () {
    test(
        'should emit [CreateTaskLoadingState, CreateTaskSuccessState] when successful',
        () {
      when(() => mockCreateTaskUseCase.call(testTask))
          .thenAnswer((_) async => const Left(1));

      createTaskCubit.createTask(testTask);

      expect(
        createTaskCubit.stream,
        emitsInOrder([
          isA<CreateTaskLoadingState>(),
          isA<CreateTaskSuccessState>().having(
            (state) => state.taskId,
            'taskId',
            1,
          ),
        ]),
      );
    });

    test(
        'should emit [CreateTaskLoadingState, CreateTaskErrorState] when failed',
        () {
      final failure = Failure('Failed to create task');
      when(() => mockCreateTaskUseCase.call(testTask))
          .thenAnswer((_) async => Right(failure));

      createTaskCubit.createTask(testTask);

      expect(
        createTaskCubit.stream,
        emitsInOrder([
          isA<CreateTaskLoadingState>(),
          isA<CreateTaskErrorState>().having(
            (state) => state.failure,
            'failure',
            failure,
          ),
        ]),
      );
    });
  });
}
