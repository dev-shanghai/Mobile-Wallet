part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserBlocEvent extends Equatable {
  @override
  List<Object> get props => [];

  const RegisterUserBlocEvent();
}

class RegisterUserSearchCountryEvent extends RegisterUserBlocEvent {
  const RegisterUserSearchCountryEvent({required this.searchKey});

  @override
  List<Object> get props => [];

  final String searchKey;
}

class RegisterUserLoadAllCountriesEvent extends RegisterUserBlocEvent {
  const RegisterUserLoadAllCountriesEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserResetEvent extends RegisterUserBlocEvent {
  const RegisterUserResetEvent();
}

class RegisterReloadDataEvent extends RegisterUserBlocEvent {
  const RegisterReloadDataEvent();

  @override
  List<Object> get props => [];
}

class RegistrationFormEmailChanged extends RegisterUserBlocEvent {
  final String email;
  const RegistrationFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegistrationFormPasswordChanged extends RegisterUserBlocEvent {
  final String password;
  const RegistrationFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RegistrationFormPasswordConfirmed extends RegisterUserBlocEvent {
  final String password;
  const RegistrationFormPasswordConfirmed({required this.password});

  @override
  List<Object> get props => [password];
}

class RegistrationFormBirthDateChanged extends RegisterUserBlocEvent {
  final String dob;
  const RegistrationFormBirthDateChanged({required this.dob});

  @override
  List<Object> get props => [dob];
}

class RegistrationFormSubmit extends RegisterUserBlocEvent {}
