import 'package:flutter_test/flutter_test.dart';
import 'package:task_hive/features/auth/domain/use_case/auth_use_case.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late SignInUseCase signInUseCase;
  late SignUpUseCase signUpUseCase;
  late GoogleSignInUseCase googleSignInUseCase;
  late ForgetPasswordUseCase forgetPasswordUseCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(mockRepository);
    signUpUseCase = SignUpUseCase(mockRepository);
    googleSignInUseCase = GoogleSignInUseCase(mockRepository);
    forgetPasswordUseCase = ForgetPasswordUseCase(mockRepository);
  });

  group('SignInUseCase', () {
    final testUser = UserEntity(
      email: 'test@example.com',
      password: 'password123',
    );

    test('should return Success when repository returns Success', () async {
      // Arrange
      when(() => mockRepository.signIn(testUser))
          .thenAnswer((_) async => Left(Success('Sign in successful')));

      // Act
      final result = await signInUseCase.call(testUser);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (success) => expect(success.message, 'Sign in successful'),
        (failure) => fail('Should not return failure'),
      );
    });

    test('should return Failure when repository returns Failure', () async {
      // Arrange
      when(() => mockRepository.signIn(testUser))
          .thenAnswer((_) async => Right(Failure('Invalid credentials')));

      // Act
      final result = await signInUseCase.call(testUser);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (success) => fail('Should not return success'),
        (failure) => expect(failure.message, 'Invalid credentials'),
      );
    });
  });

  group('SignUpUseCase', () {
    final testUser = UserEntity(
      email: 'test@example.com',
      password: 'password123',
      name: 'Test User',
    );

    test('should return Success when repository returns Success', () async {
      // Arrange
      when(() => mockRepository.signUp(testUser))
          .thenAnswer((_) async => Left(Success('Sign up successful')));

      // Act
      final result = await signUpUseCase.call(testUser);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (success) => expect(success.message, 'Sign up successful'),
        (failure) => fail('Should not return failure'),
      );
    });
  });

  // group('GoogleSignInUseCase', () {
  //   test('should return Success when repository returns Success', () async {
  //     // Arrange
  //     when(() => mockRepository.googleSignIn())
  //         .thenAnswer((_) async => Left(Success('Google sign in successful')));

  //     // Act
  //     final result = await googleSignInUseCase.call(null);

  //     // Assert
  //     expect(result.isLeft(), true);
  //     result.fold(
  //       (success) => expect(success.message, 'Google sign in successful'),
  //       (failure) => fail('Should not return failure'),
  //     );
  //   });
  // });

  group('ForgetPasswordUseCase', () {
    final testUser = UserEntity(email: 'test@example.com');

    test('should return Success when repository returns Success', () async {
      // Arrange
      when(() => mockRepository.forgetPassword(testUser.email!))
          .thenAnswer((_) async => Left(Success('Password reset email sent')));

      // Act
      final result = await forgetPasswordUseCase.call(testUser.email!);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (success) => expect(success.message, 'Password reset email sent'),
        (failure) => fail('Should not return failure'),
      );
    });
  });
}
