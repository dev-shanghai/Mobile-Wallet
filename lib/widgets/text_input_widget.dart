import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/style/app_fonts.dart';

class TextInputWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TextInputWidget(
      {required this.onChangeTextCallback,
      required this.titleText,
      this.hintTitleText,
      this.text = "",
      this.textColor = AppColors.darkBlack,
      this.errorTextColor = AppColors.errorColor,
      this.borderColor = AppColors.darkBlack,
      this.errorBorderColor = AppColors.errorColor,
      this.validationText,
      this.isSecureEntry = false,
      this.textInputType,
      this.onTapCallback});

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();

  final String text;
  final String titleText;
  final String? hintTitleText;
  final Color textColor;
  final Color errorTextColor;
  final Color borderColor;
  final Color errorBorderColor;
  final String? validationText;
  final bool isSecureEntry;
  final TextInputType? textInputType;

  /// button press callback
  final Function(String value) onChangeTextCallback;
  final Function? onTapCallback;
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.titleText,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: widget.textColor,
          ),
        ),
        GestureDetector(
            onTap: () {},
            child: TextFormField(
              obscureText: widget.isSecureEntry,
              enableSuggestions: false,
              autocorrect: false,
              textAlign: TextAlign.start,
              initialValue: widget.text,
              keyboardType: widget.textInputType ?? TextInputType.text,
              autovalidateMode: AutovalidateMode.always,
              validator: (_) {
                if (widget.validationText != null &&
                    widget.validationText != "") {
                  return widget.validationText;
                } else {
                  return null;
                }
              },
              onChanged: (String value) {
                _onChangeTextCallback(context, value);
              },
              onTap: () {
                if (widget.onTapCallback != null) {
                  widget.onTapCallback!();
                }
              },
              style: TextStyle(
                  fontSize: AppFonts.localeSize(context, 17),
                  fontWeight: FontWeight.w300,
                  color: widget.textColor,
                  fontFamily: AppFonts.localeFont(context)),
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: AppFonts.localeSize(context, 17),
                    color: widget.errorTextColor,
                    fontWeight: FontWeight.w300,
                    fontFamily: AppFonts.localeFont(context)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.borderColor, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.errorBorderColor, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.borderColor, width: 2)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.borderColor, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.errorBorderColor, width: 2)),
                hintText: widget.hintTitleText ?? widget.titleText,
              ),
            )),
      ],
    );
  }

  /// returns file name of attachments and loads attachment
  Future<void> _onChangeTextCallback(BuildContext context, String value) async {
    widget.onChangeTextCallback(value);
  }
}
