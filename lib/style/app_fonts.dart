/// all app fonts
import 'package:flutter/widgets.dart';
import 'package:mobile_wallet/style/app_style.dart';

/// a util class for all app fonts
class AppFonts {
  /// ge the locale font based on the local language
  static String localeFont(BuildContext context) {
    if (Localizations.localeOf(context).languageCode.startsWith('ar')) {
      return AppStyle().appFontsAR;
    }
    return AppStyle().appFontsEN;
  }

  /// the locale font based on the local language
  static double localeSize(BuildContext context, double fontSize) {
    if (Localizations.localeOf(context).languageCode.startsWith('ar')) {
      return fontSize - 2;
    }
    return fontSize;
  }

  /// the locale font based on the local language
  static double localePadding(BuildContext context, double padding) {
    if (Localizations.localeOf(context).languageCode.startsWith('ar')) {
      return padding * .6;
    }
    return padding;
  }

  /// the locale font based on the local language
  static bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.startsWith('ar');
  }
}
