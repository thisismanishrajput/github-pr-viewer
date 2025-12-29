import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(const AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final success = await authRepo.login(
      username: event.username,
      password: event.password,
    );

    if (success) {
      final token = await authRepo.getToken();
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: token,
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.failure,
        error: 'Invalid credentials',
      ));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await authRepo.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event,
      Emitter<AuthState> emit,
      ) async {
    final loggedIn = await authRepo.isLoggedIn();
    if (loggedIn) {
      final token = await authRepo.getToken();
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: token,
      ));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }
}
