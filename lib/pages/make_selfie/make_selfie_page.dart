import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/pages/make_selfie/make_selfie_form.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';

class MakeSelfiePage extends StatefulWidget {
  const MakeSelfiePage({Key? key}) : super(key: key);

  @override
  _MakeSelfiePage createState() => _MakeSelfiePage();
}

class _MakeSelfiePage extends State<MakeSelfiePage> {
  CameraDescription? firstCamera;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.backgroundWhite, body: MakeSelfieForm());
  }
}
