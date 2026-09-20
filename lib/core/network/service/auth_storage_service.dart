import '../constants/storage_constants.dart';
import 'secure_storage_service.dart';

class AuthStorageService {
  final SecureStorageService secureStorage;

  AuthStorageService(this.secureStorage);

  Future<void> saveAccessToken(String token) async {
    await secureStorage.write(
      StorageConstants.accessToken,
      token,
    );
  }

  Future<String?> getAccessToken() async {
    return secureStorage.read(
      StorageConstants.accessToken,
    );
  }

  Future<void> clearToken() async {
    await secureStorage.delete(
      StorageConstants.accessToken,
    );
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();

    return token != null && token.isNotEmpty;
  }
}