import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/pages/register_user/register_user_form.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/providers/user_geo_location/bloc/user_geo_location_bloc.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  _RegisterUserPage createState() => _RegisterUserPage();
}

class _RegisterUserPage extends State<RegisterUserPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RegisterUserBloc>(context)
        .add(const RegisterUserResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        body: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => UserGeoLocationBloc()),
        ], child: const RegisterUserForm()));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
