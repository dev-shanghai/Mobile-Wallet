import 'package:flutter/material.dart';
import 'package:mobile_wallet/style/app_fonts.dart';

class TextOutputWidget extends StatelessWidget {
  const TextOutputWidget(
      {Key? key,
      required this.titleText,
      required this.bodyText,
      required this.textColor})
      : super(key: key);

  final String titleText;
  final String bodyText;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
                color: textColor,
                fontSize: AppFonts.localeSize(context, 12),
                fontWeight: FontWeight.w300,
                fontFamily: AppFonts.localeFont(context)),
          ),
          Text(
            bodyText,
            style: TextStyle(
                color: textColor,
                fontSize: AppFonts.localeSize(context, 21),
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.localeFont(context)),
          ),
        ],
      ),
    );
  }
}
