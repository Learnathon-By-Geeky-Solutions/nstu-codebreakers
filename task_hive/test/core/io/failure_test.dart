import 'package:flutter_test/flutter_test.dart';
import 'package:task_hive/core/io/failure.dart';

void main() {
  group('Failure', () {
    test('should create Failure with message', () {
      const message = 'Test error message';
      final failure = Failure(message);
      expect(failure.message, message);
    });

    test('should be equal when messages are equal', () {
      final failure1 = Failure('Same message');
      final failure2 = Failure('Same message');
      expect(failure1, failure2);
    });

    test('should not be equal when messages are different', () {
      final failure1 = Failure('Message 1');
      final failure2 = Failure('Message 2');
      expect(failure1, isNot(equals(failure2)));
    });
  });
}
