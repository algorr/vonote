import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/core/data/model/user_model.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';


part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User>? _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogout>(_onUserLogOut);

    _userSubscription = _authRepository.user.listen((user) => add(AppUserChanged(user)));
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onUserLogOut(AppLogout event, Emitter<AppState> emit) {
    unawaited(_authRepository.logOut());
  }

    @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
