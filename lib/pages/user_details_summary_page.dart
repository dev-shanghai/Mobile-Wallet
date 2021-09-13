import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/constants/images.dart';
import 'package:mobile_wallet/constants/pages.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/app_image.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';
import 'package:mobile_wallet/widgets/text_output_widget.dart';

class UserDetailssummaryPage extends StatefulWidget {
  const UserDetailssummaryPage({Key? key}) : super(key: key);

  @override
  _UserDetailssummaryPage createState() => _UserDetailssummaryPage();
}

class _UserDetailssummaryPage extends State<UserDetailssummaryPage> {
  @override
  Widget build(BuildContext context) {
    final _registerUserBloc = BlocProvider.of<RegisterUserBloc>(context);
    String _email = _registerUserBloc.userDetails?.userEmail ?? "";
    String _birthDate = _registerUserBloc.userDetails?.userDateOfBirth ?? "";
    String _countryName =
        _registerUserBloc.userDetails?.userPrefferedCountry ?? "";
    String _userProfileImagePath =
        _registerUserBloc.userDetails?.userProfileImagePath ?? "";

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Summary ",
                          style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: AppFonts.localeSize(context, 35),
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.localeFont(context)),
                        ),
                        const SizedBox(height: 25),
                        _userProfileImagePath.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: Image.file(
                                  File(_userProfileImagePath),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: AppImage.asset(
                                  assetName: profilePlaceHolderImage,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )),
                              ),
                        const SizedBox(height: 20),
                        TextOutputWidget(
                          titleText: "Email",
                          bodyText: _email,
                          textColor: AppColors.textBlack,
                        ),
                        TextOutputWidget(
                          titleText: "Birth Date",
                          bodyText: _birthDate,
                          textColor: AppColors.textBlack,
                        ),
                        TextOutputWidget(
                          titleText: "Residence",
                          bodyText: _countryName,
                          textColor: AppColors.textBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                      buttonTitle: "REGISTER",
                      backgroundColor: AppColors.darkBlack,
                      textColor: AppColors.textWhite,
                      onPressButtonCallback: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, dashboardPageRoute, (r) => false);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
