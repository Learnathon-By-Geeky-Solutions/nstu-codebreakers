import 'package:flutter_test/flutter_test.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('should create UserEntity instance with all fields', () {
      final user = UserEntity(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
      );

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
    });

    test('should create UserEntity instance with minimal fields', () {
      final user = UserEntity(
        email: 'john@example.com',
        password: 'password123',
      );

      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
      expect(user.id, isNull);
      expect(user.name, isNull);
    });

    test('fromJson should create valid UserEntity', () {
      final json = {
        'id': 1,
        'full_name': 'John Doe',
        'email': 'john@example.com',
        'password': 'password123',
      };

      final user = UserEntity.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
    });

    test('toJson should create valid JSON', () {
      final user = UserEntity(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        profilePictureUrl: 'http://example.com/pic.jpg',
        createdAt: '2025-04-29T10:00:00Z',
        updatedAt: '2025-04-29T10:00:00Z',
      );

      final json = user.toJson();

      expect(json['id'], 1);
      expect(json['full_name'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['password'], 'password123');
      expect(json['profile_picture'], 'http://example.com/pic.jpg');
      expect(json['created_at'], '2025-04-29T10:00:00Z');
      expect(json['updated_at'], '2025-04-29T10:00:00Z');

      // Test with minimal fields
      final minimalUser = UserEntity(
        name: 'John Doe',
        email: 'john@example.com',
        profilePictureUrl: 'http://example.com/pic.jpg',
      );

      final minimalJson = minimalUser.toJson();
      expect(minimalJson['full_name'], 'John Doe');
      expect(minimalJson['email'], 'john@example.com');
      expect(minimalJson['profile_picture'], 'http://example.com/pic.jpg');
      expect(minimalJson['id'], isNull);
      expect(minimalJson['password'], isNull);
    });

    test('should create UserEntity with all properties', () {
      final user = UserEntity(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        profilePictureUrl: 'http://example.com/pic.jpg',
        createdAt: '2025-04-29T10:00:00Z',
        updatedAt: '2025-04-29T10:00:00Z',
      );

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
      expect(user.profilePictureUrl, 'http://example.com/pic.jpg');
      expect(user.createdAt, '2025-04-29T10:00:00Z');
      expect(user.updatedAt, '2025-04-29T10:00:00Z');
    });

    test('fromJson should create UserEntity from JSON', () {
      final json = {
        'id': 1,
        'full_name': 'John Doe',
        'email': 'john@example.com',
        'password': 'password123',
      };

      final user = UserEntity.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
    });

    test('should handle null values in JSON', () {
      final json = {
        'id': null,
        'full_name': null,
        'email': null,
        'password': null,
      };

      final user = UserEntity.fromJson(json);

      expect(user.id, null);
      expect(user.name, null);
      expect(user.email, null);
      expect(user.password, null);
    });
  });
}
