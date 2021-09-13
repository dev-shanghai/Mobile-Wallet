import 'dart:async';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_wallet/providers/register_user/models/country_search_response_model.dart';
import 'package:mobile_wallet/providers/register_user/models/user_details_model.dart';
import 'package:mobile_wallet/providers/register_user/register_user_provider.dart';

part 'register_user_bloc_event.dart';
part 'register_user_bloc_state.dart';

class RegisterUserBloc
    extends Bloc<RegisterUserBlocEvent, RegisterUserBlocState> {
  RegisterUserBloc() : super(RegisterUserInitial());

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  UserDetailsModel? userDetails;
  List<CountryModel>? countryList;

  @override
  Stream<RegisterUserBlocState> mapEventToState(
    RegisterUserBlocEvent event,
  ) async* {
    if (event is RegisterUserResetEvent) {
      yield RegisterUserInitial();
    } else if (event is RegisterUserSearchCountryEvent) {
      final CountrySearchResponseModel countryListResponseModel =
          await RegisterUserProvider().getAllCountriesList();
      if (countryListResponseModel.data.isEmpty) {
        yield RegisterUserFailure();
      } else {
        countryList = countryListResponseModel.data;
        yield RegisterUserCountryListLoaded(countryListResponseModel.data);
      }
    } else if (event is RegisterUserLoadAllCountriesEvent) {
      final CountrySearchResponseModel countryListResponseModel =
          await RegisterUserProvider().getAllCountriesList();
      if (countryListResponseModel.data.isEmpty) {
        yield RegisterUserFailure();
      } else {
        countryList = countryListResponseModel.data;
        yield RegisterUserCountryListLoaded(countryListResponseModel.data);
      }
    } else if (event is RegisterReloadDataEvent) {
      yield RegisterUserReloadState();
    } else if (event is RegistrationFormEmailChanged) {
      userDetails?.userEmail = event.email;
      yield RegisterUserEmailValidation(isEmailValid(event.email));
    } else if (event is RegistrationFormPasswordChanged) {
      userDetails?.userPassword = event.password;
      yield RegisterUserPasswordValidation(isPasswordValid(event.password));
    } else if (event is RegistrationFormPasswordConfirmed) {
      userDetails?.userConfirmedPassword = event.password;
      yield RegisterUserPasswordConfirmation(
          isValid: isPasswordValid(event.password),
          isMatched: (userDetails?.userPassword == event.password));
    } else if (event is RegistrationFormBirthDateChanged) {
      userDetails?.userDateOfBirth = event.dob;
      yield RegisterUserBirthDateValidation(isDOBValid(event.dob));
    } else if (event is RegistrationFormSubmit) {
      if (isEmailValid(userDetails?.userEmail ?? "") &&
          isPasswordValid(userDetails?.userPassword ?? "") &&
          isPasswordValid(userDetails?.userConfirmedPassword ?? "") &&
          isDOBValid(userDetails?.userDateOfBirth ?? "") &&
          isCountryNameValid(userDetails?.userPrefferedCountry ?? "")) {
        yield const RegisterUserFormValidation(true);
      } else {
        if (!isEmailValid(userDetails?.userEmail ?? "")) {
          yield const RegisterUserEmailValidation(false);
        } else if (!isPasswordValid(userDetails?.userPassword ?? "")) {
          yield const RegisterUserPasswordValidation(false);
        } else if (!isPasswordValid(userDetails?.userConfirmedPassword ?? "")) {
          yield RegisterUserPasswordConfirmation(
              isValid:
                  isPasswordValid(userDetails?.userConfirmedPassword ?? ""),
              isMatched: (userDetails?.userPassword ==
                  userDetails?.userConfirmedPassword));
        } else if (!isDOBValid(userDetails?.userDateOfBirth ?? "")) {
          yield const RegisterUserBirthDateValidation(false);
        } else if (!isCountryNameValid(
            userDetails?.userPrefferedCountry ?? "")) {
          yield const RegisterUserCountryNameValidation(false);
        }
      }
    }
  }

  bool isEmailValid(String email) {
    return email.length >= 5 && _emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.length >= 5 && _passwordRegExp.hasMatch(password);
  }

  bool isDOBValid(String dob) {
    try {
      var dateTime = DateFormat('dd/MM/yyyy').parse(dob);
      if (dateTime.year == DateTime.now().year) {
        return false;
      } else if (dateTime.year < 1900) {
        return false;
      } else if (dateTime.year <= (DateTime.now().year - 15)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool isCountryNameValid(String country) {
    return country.isNotEmpty && country.length >= 3;
  }
}
