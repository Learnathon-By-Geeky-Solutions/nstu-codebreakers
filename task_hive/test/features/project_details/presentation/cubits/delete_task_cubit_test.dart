import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/use_case/project_details_use_case.dart';
import 'package:task_hive/features/project_details/presentation/cubits/delete_task/detele_task_cubit.dart';
import 'package:dartz/dartz.dart';

class MockDeleteTaskUseCase extends Mock implements DeleteTasksUseCase {}

void main() {
  late DeleteTaskCubit deleteTaskCubit;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;

  setUp(() {
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    deleteTaskCubit = DeleteTaskCubit(mockDeleteTaskUseCase);
  });

  tearDown(() {
    deleteTaskCubit.close();
  });

  test('initial state should be DeleteTaskInitial', () {
    expect(deleteTaskCubit.state, isA<DeleteTaskInitial>());
  });

  group('deleteTask', () {
    final success = Success('Task deleted successfully');

    blocTest<DeleteTaskCubit, DeleteTaskState>(
      'should emit [DeleteTaskLoading, DeleteTaskSuccess] when successful',
      build: () => deleteTaskCubit,
      act: (cubit) {
        when(() => mockDeleteTaskUseCase.call(1))
            .thenAnswer((_) async => Left(success));
        cubit.deleteTask(1);
      },
      expect: () => [
        isA<DeleteTaskLoading>(),
        isA<DeleteTaskSuccess>().having(
          (state) => state.success,
          'success',
          success,
        ),
      ],
    );

    blocTest<DeleteTaskCubit, DeleteTaskState>(
      'should emit [DeleteTaskLoading, DeleteTaskFailure] when failed',
      build: () => deleteTaskCubit,
      act: (cubit) {
        final failure = Failure('Failed to delete task');
        when(() => mockDeleteTaskUseCase.call(1))
            .thenAnswer((_) async => Right(failure));
        cubit.deleteTask(1);
      },
      expect: () => [
        isA<DeleteTaskLoading>(),
        isA<DeleteTaskFailure>().having(
          (state) => state.failure,
          'failure',
          isA<Failure>().having((f) => f.message, 'message', 'Failed to delete task'),
        ),
      ],
    );

    test('verifies delete task use case is called with correct task id', () {
      when(() => mockDeleteTaskUseCase.call(1))
          .thenAnswer((_) async => Left(success));

      deleteTaskCubit.deleteTask(1);

      verify(() => mockDeleteTaskUseCase.call(1)).called(1);
    });
  });
}
