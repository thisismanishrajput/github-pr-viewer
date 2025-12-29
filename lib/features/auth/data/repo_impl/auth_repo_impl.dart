import 'dart:async';

import '../../domain/repo/auth_repo.dart';

import '../service/auth_local_service.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthLocalService _localService;

  AuthRepoImpl(this._localService);

  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username.isNotEmpty && password.isNotEmpty) {
      final token =
          'abc123_github_${DateTime.now().millisecondsSinceEpoch}';
      await _localService.saveToken(token);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await _localService.deleteToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return await _localService.getToken();
  }
}
