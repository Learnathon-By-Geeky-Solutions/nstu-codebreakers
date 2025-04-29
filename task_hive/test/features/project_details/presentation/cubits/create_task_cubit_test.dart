import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_hive/core/io/failure.dart';
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
    blocTest<CreateTaskCubit, CreateTaskState>(
      'should emit [CreateTaskLoadingState, CreateTaskSuccessState] when successful',
      build: () => createTaskCubit,
      act: (cubit) {
        when(() => mockCreateTaskUseCase.call(testTask))
            .thenAnswer((_) async => const Right(1));
        cubit.createTask(testTask);
      },
      expect: () => [
        isA<CreateTaskLoadingState>(),
        isA<CreateTaskSuccessState>().having(
          (state) => state.taskId,
          'taskId',
          1,
        ),
      ],
    );

    blocTest<CreateTaskCubit, CreateTaskState>(
      'should emit [CreateTaskLoadingState, CreateTaskErrorState] when failed',
      build: () => createTaskCubit,
      act: (cubit) {
        final failure = Failure('Failed to create task');
        when(() => mockCreateTaskUseCase.call(testTask))
            .thenAnswer((_) async => Left(failure));
        cubit.createTask(testTask);
      },
      expect: () => [
        isA<CreateTaskLoadingState>(),
        isA<CreateTaskErrorState>().having(
          (state) => state.failure,
          'failure',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Failed to create task'),
        ),
      ],
    );

    test('verifies create task use case is called with correct task', () {
      when(() => mockCreateTaskUseCase.call(testTask))
          .thenAnswer((_) async => const Right(1));

      createTaskCubit.createTask(testTask);

      verify(() => mockCreateTaskUseCase.call(testTask)).called(1);
    });
  });
}
