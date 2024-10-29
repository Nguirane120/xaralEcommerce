
import 'package:ecmmerce/apiservice.dart';
import 'package:ecmmerce/bloc/bloc/auth_event.dart';
import 'package:ecmmerce/bloc/bloc/auth_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final ApiService apiService;

  AuthBloc(this.apiService) : super(Unauthenticated()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await apiService.login(event.username, event.password);
        emit(Authenticated(token));
      } catch (e) {
        emit(AuthError("Login failed. Please check your credentials."));
      }
    });

    on<LogoutRequested>((event, emit) {
      emit(Unauthenticated());
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      final token = json['token'] as String?;
      if (token != null) {
        return Authenticated(token);
      } else {
        return Unauthenticated();
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is Authenticated) {
      return {'token': state.token};
    }
    return null; 
  }
}
