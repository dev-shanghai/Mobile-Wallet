import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/style/app_fonts.dart';
import 'package:mobile_wallet/widgets/main_app_bar.dart';
import 'package:mobile_wallet/widgets/main_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        height: ValueNotifier<double>(56.0),
        title: ValueNotifier<String>("Mobile Wallet"),
      ),
      backgroundColor: AppColors.backgroundWhite,
      drawer: const MainDrawer(),
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
                          "Dashboard ",
                          style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: AppFonts.localeSize(context, 35),
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.localeFont(context)),
                        ),
                        const SizedBox(height: 25),
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
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
