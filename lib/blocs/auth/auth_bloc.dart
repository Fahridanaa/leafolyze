import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/blocs/auth/auth_state.dart';
import 'package:leafolyze/repositories/auth_repository.dart';
import 'package:leafolyze/services/storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;
  Timer? _refreshTimer;

  AuthBloc(this._authRepository, this._storageService) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
          _startRefreshTimer();
        } else {
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(user));
      _startRefreshTimer();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        birth: event.birth,
        gender: event.gender,
        address: event.address,
        access: 'petani',
      );
      emit(Authenticated(user));
      _startRefreshTimer();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _stopRefreshTimer();
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _startRefreshTimer() async {
    _stopRefreshTimer();

    final token = await _storageService.getToken();
    if (token == null) {
      add(LogoutRequested()); // Log out if no token exists
      return;
    }

    final expirationDate =
        token.createdAt.add(Duration(seconds: token.expiresIn));
    final now = DateTime.now();
    final timeUntilRefresh = expirationDate.difference(now) -
        const Duration(minutes: 2); // Refresh 2 minutes before expiration

    if (timeUntilRefresh.isNegative) {
      add(LogoutRequested());
      return;
    }

    // Schedule refresh close to expiration
    _refreshTimer = Timer(timeUntilRefresh, () async {
      try {
        await _authRepository.refreshTokenIfNeeded();
        _startRefreshTimer(); // Restart timer with new expiration
      } catch (e) {
        print('Refresh timer error: $e');
        _stopRefreshTimer();
        add(LogoutRequested()); // Log out if refresh fails
      }
    });
  }

  void _stopRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  Future<void> close() {
    _stopRefreshTimer();
    return super.close();
  }
}
