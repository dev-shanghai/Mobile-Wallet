part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserBlocState extends Equatable {
  @override
  List<Object> get props => [];

  const RegisterUserBlocState();
}

class RegisterUserInitial extends RegisterUserBlocState {}

class RegisterUserCountryListLoaded extends RegisterUserBlocState {
  const RegisterUserCountryListLoaded(this.countryList);

  @override
  List<Object> get props => [countryList];
  final List<CountryModel> countryList;
}

class RegisterUserReloadState extends RegisterUserBlocState {}

class RegisterUserFailure extends RegisterUserBlocState {}

class RegisterUserEmailValidation extends RegisterUserBlocState {
  const RegisterUserEmailValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
  final bool isValid;
}

class RegisterUserPasswordValidation extends RegisterUserBlocState {
  const RegisterUserPasswordValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
  final bool isValid;
}

class RegisterUserPasswordConfirmation extends RegisterUserBlocState {
  const RegisterUserPasswordConfirmation(
      {required this.isValid, required this.isMatched});

  @override
  List<Object> get props => [isValid];
  final bool isMatched;
  final bool isValid;
}

class RegisterUserCountryNameValidation extends RegisterUserBlocState {
  const RegisterUserCountryNameValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
  final bool isValid;
}

class RegisterUserBirthDateValidation extends RegisterUserBlocState {
  const RegisterUserBirthDateValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
  final bool isValid;
}

class RegisterUserFormValidation extends RegisterUserBlocState {
  const RegisterUserFormValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
  final bool isValid;
}
