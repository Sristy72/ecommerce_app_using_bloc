import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../network/service/auth_storage_service.dart';
import '../network/service/hive_storage_service.dart';
import '../network/service/secure_storage_service.dart';


final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Network
  getIt.registerLazySingleton<ApiClient>(
        () => ApiClient(),
  );

  // Storage
  getIt.registerLazySingleton<SecureStorageService>(
        () => SecureStorageService(),
  );

  getIt.registerLazySingleton<AuthStorageService>(
        () => AuthStorageService(
      getIt<SecureStorageService>(),
    ),
  );

  getIt.registerLazySingleton<HiveStorageService>(
        () => HiveStorageService(),
  );
}