import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/constants/images.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/widgets/app_image.dart';
import 'package:mobile_wallet/widgets/text_output_widget.dart';

class MainDrawer extends StatefulWidget {
  /// constructor
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final _registerUserBloc = BlocProvider.of<RegisterUserBloc>(context);
    String _email = _registerUserBloc.userDetails?.userEmail ?? "";
    String _birthDate = _registerUserBloc.userDetails?.userDateOfBirth ?? "";
    String _countryName =
        _registerUserBloc.userDetails?.userPrefferedCountry ?? "";
    String _userProfileImagePath =
        _registerUserBloc.userDetails?.userProfileImagePath ?? "";

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.darkBlack,
      ),
      child: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: AppColors.darkBlack,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _userProfileImagePath.isNotEmpty
                            ? Container(
                                height: 120,
                                width: 120,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: ClipOval(
                                        child: Image.file(
                                      File(_userProfileImagePath),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                ),
                              )
                            : Container(
                                height: 120,
                                width: 120,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                      child: AppImage.asset(
                                    assetName: profilePlaceHolderImage,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )),
                                ),
                              ),
                        const SizedBox(height: 20),
                        TextOutputWidget(
                          titleText: "Email",
                          bodyText: _email,
                          textColor: AppColors.textWhite,
                        ),
                        TextOutputWidget(
                          titleText: "Birth Date",
                          bodyText: _birthDate,
                          textColor: AppColors.textWhite,
                        ),
                        TextOutputWidget(
                          titleText: "Residence",
                          bodyText: _countryName,
                          textColor: AppColors.textWhite,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 35,
                        ),
                        color: AppColors.textWhite,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 7.5,
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.backgroundWhite.withOpacity(0.25),
                      AppColors.backgroundWhite.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
