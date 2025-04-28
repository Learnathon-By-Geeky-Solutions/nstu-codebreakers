import 'package:flutter_test/flutter_test.dart';
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
    test('should emit [DeleteTaskLoading, DeleteTaskSuccess] when successful',
        () {
      final success = Success('Task deleted successfully');
      when(() => mockDeleteTaskUseCase.call(1))
          .thenAnswer((_) async => Left(success));

      deleteTaskCubit.deleteTask(1);

      expect(
        deleteTaskCubit.stream,
        emitsInOrder([
          isA<DeleteTaskLoading>(),
          isA<DeleteTaskSuccess>().having(
            (state) => state.success,
            'success',
            success,
          ),
        ]),
      );
    });

    test('should emit [DeleteTaskLoading, DeleteTaskFailure] when failed', () {
      final failure = Failure('Failed to delete task');
      when(() => mockDeleteTaskUseCase.call(1))
          .thenAnswer((_) async => Right(failure));

      deleteTaskCubit.deleteTask(1);

      expect(
        deleteTaskCubit.stream,
        emitsInOrder([
          isA<DeleteTaskLoading>(),
          isA<DeleteTaskFailure>().having(
            (state) => state.failure,
            'failure',
            failure,
          ),
        ]),
      );
    });

    test('verifies delete task use case is called with correct task id', () {
      final success = Success('Task deleted successfully');
      when(() => mockDeleteTaskUseCase.call(1))
          .thenAnswer((_) async => Left(success));

      deleteTaskCubit.deleteTask(1);

      verify(() => mockDeleteTaskUseCase.call(1)).called(1);
    });
  });
}
