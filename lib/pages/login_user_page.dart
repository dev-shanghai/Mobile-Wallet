import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';
import 'package:mobile_wallet/widgets/text_input_widget.dart';

class LoginUserPage extends StatefulWidget {
  const LoginUserPage({Key? key}) : super(key: key);

  @override
  _LoginUserPage createState() => _LoginUserPage();
}

class _LoginUserPage extends State<LoginUserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            "Login ",
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
                                      TextInputWidget(
                                          titleText: "Email",
                                          validationText: "",
                                          textInputType:
                                              TextInputType.emailAddress,
                                          onChangeTextCallback: (value) {}),
                                      const SizedBox(height: 10),
                                      TextInputWidget(
                                          titleText: "Password",
                                          isSecureEntry: true,
                                          validationText: "",
                                          onChangeTextCallback: (value) {}),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                        onPressButtonCallback: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
