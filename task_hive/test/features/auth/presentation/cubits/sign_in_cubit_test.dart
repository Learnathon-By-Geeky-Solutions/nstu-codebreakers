import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';
import 'package:task_hive/features/auth/domain/use_case/auth_use_case.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  late SignInCubit signInCubit;
  late MockSignInUseCase mockSignInUseCase;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    signInCubit = SignInCubit(mockSignInUseCase);
  });

  tearDown(() {
    signInCubit.close();
  });

  test('initial state is SignInState', () {
    expect(signInCubit.state, isA<SignInState>());
  });

  group('signIn', () {
    final testUser = UserEntity(
      email: 'test@example.com',
      password: 'password123',
    );

    test('emits [SignInLoading, SignInSuccess] when signIn is successful',
        () async {
      final success = Success('Sign in successful');
      when(() => mockSignInUseCase.call(testUser))
          .thenAnswer((_) async => Right(success));

      final expectedStates = [
        isA<SignInLoading>(),
        isA<SignInSuccess>()
            .having((state) => state.success, 'success', success),
      ];

      expectLater(signInCubit.stream, emitsInOrder(expectedStates));

      signInCubit.signIn(testUser);
      verify(() => mockSignInUseCase.call(testUser)).called(1);
    });

    test('emits [SignInLoading, SignInFailed] when signIn fails', () async {
      final failure = Failure('Invalid credentials');
      when(() => mockSignInUseCase.call(testUser))
          .thenAnswer((_) async => Left(failure));

      final expectedStates = [
        isA<SignInLoading>(),
        isA<SignInFailed>()
            .having((state) => state.failure, 'failure', failure),
      ];

      expectLater(signInCubit.stream, emitsInOrder(expectedStates));

      signInCubit.signIn(testUser);
      verify(() => mockSignInUseCase.call(testUser)).called(1);
    });
  });
}
