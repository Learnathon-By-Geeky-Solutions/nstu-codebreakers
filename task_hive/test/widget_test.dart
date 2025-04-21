import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';

import 'mocks/mock_auth_service.dart';

void main() {
  final getIt = GetIt.instance;

  late MockAuthService mockAuthService;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  setUpAll(() {
    mockAuthService = MockAuthService();
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();

    // Setup mocks
    when(() => mockAuthService.getSupabaseClient())
        .thenReturn(mockSupabaseClient);
    when(() => mockAuthService.getAuthClient()).thenReturn(mockGoTrueClient);

    // Register mocks into GetIt
    getIt.registerSingleton<AuthService>(mockAuthService);

    // Register other dependencies if needed
    // e.g., getIt.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  });

  testWidgets('Counter increments smoke test', (tester) async {
    // your widget test code here...
  });
}
