import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/constants/images.dart';
import 'package:mobile_wallet/constants/pages.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/app_image.dart';
import 'package:mobile_wallet/widgets/button_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
                    child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                        color: AppColors.appSplashColor,
                        child: FittedBox(
                          child: AppImage.asset(
                              assetName: splashBackgroundImage,
                              fit: BoxFit.fitWidth),
                          fit: BoxFit.fitHeight,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        " Photo ",
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: AppFonts.localeSize(context, 35),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontFamily: AppFonts.localeFont(context),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          Container(
            height: 75,
            color: AppColors.completeTransparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ButtonWidget(
                      buttonTitle: "LOG IN",
                      backgroundColor: AppColors.backgroundWhite,
                      textColor: AppColors.textBlack,
                      borderColor: AppColors.darkBlack,
                      onPressButtonCallback: () {
                        Navigator.pushNamed(context, loginPageRoute);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ButtonWidget(
                      buttonTitle: "REGISTER",
                      backgroundColor: AppColors.darkBlack,
                      textColor: AppColors.textWhite,
                      onPressButtonCallback: () {
                        Navigator.pushNamed(context, regsiterPageRoute);
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
