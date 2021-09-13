import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/pages/dashboard_page.dart';
import 'package:mobile_wallet/pages/login_user_page.dart';
import 'package:mobile_wallet/pages/make_selfie/make_selfie_page.dart';
import 'package:mobile_wallet/pages/register_user/register_user_page.dart';
import 'package:mobile_wallet/pages/splash_page.dart';
import 'package:mobile_wallet/pages/user_details_summary_page.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'constants/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _buildMainApp(context);
  }

  Widget _buildMainApp(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserBloc(),
      child: MaterialApp(
        title: "Mobile Wallet",
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        })),
        color: AppColors.darkBlack,
        home: const SplashPage(),
        routes: <String, WidgetBuilder>{
          splashPageRoute: (BuildContext context) => const SplashPage(),
          regsiterPageRoute: (BuildContext context) => const RegisterUserPage(),
          captureSelfiePageRoute: (BuildContext context) =>
              const MakeSelfiePage(),
          userDetailssummaryPageRoute: (BuildContext context) =>
              const UserDetailssummaryPage(),
          dashboardPageRoute: (BuildContext context) => const DashboardPage(),
          loginPageRoute: (BuildContext context) => const LoginUserPage()
        },
      ),
    );
  }
}
