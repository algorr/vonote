part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutEvent extends AppEvent {}

class AppUserChangedEvent extends AppEvent {
  final User user;

  const AppUserChangedEvent(this.user);

    @override
  List<Object> get props => [user];

}
