import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/auth/domain/use_case/auth_use_case.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_in/google_sign_in_cubit.dart';
import 'package:dartz/dartz.dart';

class MockGoogleSignInUseCase extends Mock implements GoogleSignInUseCase {}

void main() {
  late GoogleSignInCubit googleSignInCubit;
  late MockGoogleSignInUseCase mockGoogleSignInUseCase;

  setUp(() {
    mockGoogleSignInUseCase = MockGoogleSignInUseCase();
    googleSignInCubit = GoogleSignInCubit(mockGoogleSignInUseCase);
  });

  tearDown(() {
    googleSignInCubit.close();
  });

  test('initial state should be GoogleSignInInitial', () {
    expect(googleSignInCubit.state, isA<GoogleSignInInitial>());
  });

  group('signInWithGoogle', () {
    test(
        'should emit [GoogleSignInLoading, GoogleSignInSuccess] when successful',
        () {
      final success = Success('Google sign in successful');
      when(() => mockGoogleSignInUseCase.call(null))
          .thenAnswer((_) async => Left(success));

      googleSignInCubit.signInWithGoogle();

      expect(
        googleSignInCubit.stream,
        emitsInOrder([
          isA<GoogleSignInLoading>(),
          isA<GoogleSignInSuccess>().having(
            (state) => state.success,
            'success',
            success,
          ),
        ]),
      );
    });

    test('should emit [GoogleSignInLoading, GoogleSignInFailed] when failed',
        () {
      final failure = Failure('Google sign in failed');
      when(() => mockGoogleSignInUseCase.call(null))
          .thenAnswer((_) async => Right(failure));

      googleSignInCubit.signInWithGoogle();

      expect(
        googleSignInCubit.stream,
        emitsInOrder([
          isA<GoogleSignInLoading>(),
          isA<GoogleSignInFailed>().having(
            (state) => state.failure,
            'failure',
            failure,
          ),
        ]),
      );
    });

    test(
        'should emit [GoogleSignInLoading, GoogleSignInFailed] when exception occurs',
        () {
      when(() => mockGoogleSignInUseCase.call(null))
          .thenThrow(Exception('Google auth error'));

      googleSignInCubit.signInWithGoogle();

      expect(
        googleSignInCubit.stream,
        emitsInOrder([
          isA<GoogleSignInLoading>(),
          isA<GoogleSignInFailed>().having(
            (state) => state.failure.message,
            'failure message',
            'Google auth error',
          ),
        ]),
      );
    });

    test('verifies google sign in use case is called', () {
      final success = Success('Google sign in successful');
      when(() => mockGoogleSignInUseCase.call(null))
          .thenAnswer((_) async => Left(success));

      googleSignInCubit.signInWithGoogle();

      verify(() => mockGoogleSignInUseCase.call(null)).called(1);
    });
  });
}
