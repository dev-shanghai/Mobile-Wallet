import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/app_image.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';

import 'package:mobile_wallet/constants/images.dart';
import 'package:mobile_wallet/constants/pages.dart';
import 'package:mobile_wallet/pages/take_picture_page.dart';

class MakeSelfieForm extends StatefulWidget {
  const MakeSelfieForm({Key? key}) : super(key: key);

  @override
  State<MakeSelfieForm> createState() => _MakeSelfieFormState();
}

class _MakeSelfieFormState extends State<MakeSelfieForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterUserBloc, RegisterUserBlocState>(
      listener: (context, state) {},
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Make a Selfie ",
                          style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: AppFonts.localeSize(context, 35),
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.localeFont(context)),
                        ),
                        const SizedBox(height: 75),
                        BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
                          builder: (context, state) {
                            String userProfileImagePath = "";
                            final registerUserBloc =
                                BlocProvider.of<RegisterUserBloc>(context);
                            userProfileImagePath = registerUserBloc
                                    .userDetails?.userProfileImagePath ??
                                "";

                            if (userProfileImagePath.isNotEmpty) {
                              return Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: Image.file(
                                  File(userProfileImagePath),
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                )),
                              );
                            }

                            return Container(
                              alignment: Alignment.center,
                              child: ClipOval(
                                  child: AppImage.asset(
                                assetName: profilePlaceHolderImage,
                                height: 250,
                                width: 250,
                                fit: BoxFit.cover,
                              )),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrayColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppColors.darkBlack
                                            .withOpacity(0.5),
                                        offset: const Offset(0, 1))
                                  ],
                                ),
                                child: const Icon(
                                  Icons.camera_alt_sharp,
                                  color: AppColors.darkBlack,
                                  size: 42,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TakePicturePage(
                                  didFinishTakingPicture: (value) async {
                                    final path = value.path;
                                    final registerUserBloc =
                                        BlocProvider.of<RegisterUserBloc>(
                                            context);

                                    registerUserBloc.userDetails
                                        ?.userProfileImagePath = path;
                                    registerUserBloc
                                        .add(const RegisterUserResetEvent());

                                    registerUserBloc
                                        .add(const RegisterReloadDataEvent());
                                  },
                                ),
                              ),
                            );
                          },
                        )
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
                      buttonTitle: "NEXT",
                      backgroundColor: AppColors.darkBlack,
                      textColor: AppColors.textWhite,
                      onPressButtonCallback: () {
                        Navigator.pushNamed(
                            context, userDetailssummaryPageRoute);
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
