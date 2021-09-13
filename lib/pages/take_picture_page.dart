import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({
    Key? key,
    required this.didFinishTakingPicture,
  }) : super(key: key);

  final Function(XFile image) didFinishTakingPicture;

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller;
  bool _isInited = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final cameras = await availableCameras();

      _controller = CameraController(cameras[1], ResolutionPreset.medium);
      _controller.initialize().then((value) => {
            setState(() {
              _isInited = true;
            })
          });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Stack(
      children: <Widget>[
        _isInited
            ? Center(
                child: Transform.scale(
                  scale: _controller.value.aspectRatio / deviceRatio,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
              )
            : Container(
                color: AppColors.backgroundWhite,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.darkBlack,
                  ),
                ),
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            backgroundColor: AppColors.backgroundWhite,
            onPressed: () async {
              if (!_controller.value.isInitialized) {}

              if (_controller.value.isTakingPicture) {
                // A capture is already pending, do nothing.
              }

              try {
                XFile file = await _controller.takePicture();
                Navigator.pop(context);
                widget.didFinishTakingPicture(file);
              } on CameraException catch (_) {}
            },
            child: const Icon(
              Icons.camera_alt,
              color: AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
