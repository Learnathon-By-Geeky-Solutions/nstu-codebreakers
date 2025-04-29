import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
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
    blocTest<GoogleSignInCubit, GoogleSignInState>(
      'should emit [GoogleSignInLoading, GoogleSignInSuccess] when successful',
      build: () {
        final success = Success('Google sign in successful');
        when(() => mockGoogleSignInUseCase.call(null))
            .thenAnswer((_) async => Right(success));
        return googleSignInCubit;
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        isA<GoogleSignInLoading>(),
        isA<GoogleSignInSuccess>().having(
          (state) => state.success,
          'success',
          isA<Success>(),
        ),
      ],
      verify: (_) {
        verify(() => mockGoogleSignInUseCase.call(null)).called(1);
      },
    );

    blocTest<GoogleSignInCubit, GoogleSignInState>(
      'should emit [GoogleSignInLoading, GoogleSignInFailed] when failed',
      build: () {
        final failure = Failure('Google sign in failed');
        when(() => mockGoogleSignInUseCase.call(null))
            .thenAnswer((_) async => Left(failure));
        return googleSignInCubit;
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        isA<GoogleSignInLoading>(),
        isA<GoogleSignInFailed>().having(
          (state) => state.failure,
          'failure',
          isA<Failure>(),
        ),
      ],
    );

    blocTest<GoogleSignInCubit, GoogleSignInState>(
      'should emit [GoogleSignInLoading, GoogleSignInFailed] when exception occurs',
      build: () {
        when(() => mockGoogleSignInUseCase.call(null))
            .thenThrow(Exception('Google auth error'));
        return googleSignInCubit;
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        isA<GoogleSignInLoading>(),
        isA<GoogleSignInFailed>().having(
          (state) => state.failure.message,
          'failure message',
          'Google auth error',
        ),
      ],
    );
  });
}
