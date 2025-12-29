abstract class AuthRepo {
  Future<bool> login({required String username, required String password});

  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<String?> getToken();
}
