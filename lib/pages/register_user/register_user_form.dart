import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/pages/register_user/country_search_input.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/providers/register_user/models/user_details_model.dart';
import 'package:mobile_wallet/providers/user_geo_location/bloc/user_geo_location_bloc.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';
import 'package:mobile_wallet/widgets/text_input_widget.dart';
import 'package:mobile_wallet/constants/pages.dart';

class RegisterUserForm extends StatefulWidget {
  const RegisterUserForm({Key? key}) : super(key: key);

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<UserGeoLocationBloc>(context)
        .add(const UserGeoLocationDetermineCountry());
    BlocProvider.of<RegisterUserBloc>(context)
        .add(const RegisterUserLoadAllCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    RegisterUserBloc _registrationBloc =
        BlocProvider.of<RegisterUserBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<UserGeoLocationBloc, UserGeoLocationState>(
            listener: (BuildContext context, UserGeoLocationState state) {
          if (state is UserCountryDetermined) {
            _registrationBloc.userDetails = UserDetailsModel();
            _registrationBloc.userDetails?.userPrefferedCountry =
                state.address.countryName ?? "";
            _registrationBloc.add(const RegisterReloadDataEvent());
          }
        }),
        BlocListener<RegisterUserBloc, RegisterUserBlocState>(
            listener: (BuildContext context, RegisterUserBlocState state) {
          if (state is RegisterUserFormValidation) {
            if (state.isValid) {
              Navigator.pushNamed(context, captureSelfiePageRoute);
            } else {
              //_registrationBloc.add(const RegisterReloadDataEvent());
            }
          }
        }),
      ],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      color: AppColors.backgroundWhite,
                      child: formWidgets(context),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                builder: (BuildContext context, RegisterUserBlocState state) {
              return Container(
                height: 75,
                color: AppColors.backgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ButtonWidget(
                          buttonTitle: "NEXT",
                          backgroundColor: AppColors.darkBlack,
                          textColor: AppColors.textWhite,
                          onPressButtonCallback: () {
                            var state = _registrationBloc.state;
                            if (state is RegisterUserFormValidation) {
                              if (state.isValid) {
                                Navigator.pushNamed(
                                    context, captureSelfiePageRoute);
                              }
                            } else {
                              _registrationBloc.add(RegistrationFormSubmit());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ]),
    );
  }

  Column formWidgets(BuildContext context) {
    RegisterUserBloc _registrationBloc =
        BlocProvider.of<RegisterUserBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 50),
        Text(
          "Register ",
          style: TextStyle(
              color: AppColors.textBlack,
              fontSize: AppFonts.localeSize(context, 35),
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.localeFont(context)),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 200,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                        builder: (BuildContext context,
                            RegisterUserBlocState state) {
                      var isValid = true;
                      if (state is RegisterUserEmailValidation) {
                        isValid = state.isValid;
                      }
                      return TextInputWidget(
                          titleText: "Email",
                          validationText: (isValid) ? "" : "Email invalid",
                          textInputType: TextInputType.emailAddress,
                          onChangeTextCallback: (value) {
                            _registrationBloc.add(
                                RegistrationFormEmailChanged(email: value));
                          });
                    }),
                    const SizedBox(height: 10),
                    BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                        builder: (BuildContext context,
                            RegisterUserBlocState state) {
                      var isValid = true;
                      if (state is RegisterUserPasswordValidation) {
                        isValid = state.isValid;
                      } else if (state is RegisterUserFormValidation) {
                        if (!state.isValid) {
                          isValid = false;
                        }
                      }
                      return TextInputWidget(
                          titleText: "Password",
                          isSecureEntry: true,
                          validationText: (isValid) ? "" : "Password invalid",
                          onChangeTextCallback: (value) {
                            _registrationBloc.add(
                                RegistrationFormPasswordChanged(
                                    password: value));
                          });
                    }),
                    const SizedBox(height: 10),
                    BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                        builder: (BuildContext context,
                            RegisterUserBlocState state) {
                      var validationText = "";
                      if (state is RegisterUserPasswordConfirmation) {
                        if (!state.isValid) {
                          validationText = "Password invalid";
                        } else if (!state.isMatched) {
                          validationText = "Password doesn't match.";
                        }
                      }
                      return TextInputWidget(
                          titleText: "Confirm Password",
                          isSecureEntry: true,
                          validationText: validationText,
                          onChangeTextCallback: (value) {
                            _registrationBloc.add(
                                RegistrationFormPasswordConfirmed(
                                    password: value));
                          });
                    }),
                    const SizedBox(height: 10),
                    BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                        builder: (BuildContext context,
                            RegisterUserBlocState state) {
                      var validationText = "";
                      if (state is RegisterUserBirthDateValidation) {
                        if (!state.isValid) {
                          validationText = "Invalid Birth Date";
                        }
                      }

                      return TextInputWidget(
                          titleText: "Birth Date",
                          hintTitleText: "dd/mm/yyyy",
                          isSecureEntry: false,
                          validationText: validationText,
                          textInputType: TextInputType.datetime,
                          onChangeTextCallback: (value) {
                            _registrationBloc.add(
                                RegistrationFormBirthDateChanged(dob: value));
                          });
                    }),
                    const SizedBox(height: 10),
                    BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                      builder:
                          (BuildContext context, RegisterUserBlocState state) {
                        if (state is RegisterUserCountryListLoaded) {}

                        return CountrySearchInput(
                          countriesList: _registrationBloc.countryList ?? [],
                          selectedCountryName: _registrationBloc
                                  .userDetails?.userPrefferedCountry ??
                              "",
                          didChangeValue: (value) {
                            _registrationBloc
                                .userDetails?.userPrefferedCountry = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
