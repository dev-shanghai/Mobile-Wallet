import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/style/app_fonts.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {required this.buttonTitle,
      this.borderColor = AppColors.completeTransparent,
      required this.backgroundColor,
      required this.textColor,
      required this.onPressButtonCallback});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();

  final String buttonTitle;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  /// button press callback
  final Function onPressButtonCallback;
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0),
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: widget.borderColor, width: 1),
            //backgroundColor: widget.backgroundColor,
            primary: widget.backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            textStyle: TextStyle(
                color: widget.textColor,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          _onPressOfButton(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.buttonTitle,
              style: TextStyle(
                  color: widget.textColor,
                  fontSize: AppFonts.localeSize(context, 17),
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.localeFont(context)),
            ),
          ],
        ),
      ),
    );
  }

  /// returns file name of attachments and loads attachment
  Future<void> _onPressOfButton(BuildContext context) async {
    widget.onPressButtonCallback();
  }
}
