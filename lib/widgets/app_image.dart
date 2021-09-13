import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_wallet/constants/app_colors.dart';

class AppImage {
  static Widget asset({
    Key key = const Key(""),
    String assetName = "",
    double width = 0,
    double height = 0,
    BoxFit fit = BoxFit.none,
    Color color = AppColors.completeTransparent,
  }) {
    return assetName.toLowerCase().endsWith('svg')
        ? _buildSvg(assetName,
            key: key, width: width, height: height, fit: fit, color: color)
        : _buildImageAsset(assetName,
            key: key, width: width, height: height, fit: fit);
  }

  static Widget network(String assetName,
      {Key key = const Key(""),
      double width = 0,
      double height = 0,
      BoxFit fit = BoxFit.none,
      Color color = AppColors.completeTransparent,
      String errorImage = ""}) {
    return _buildImageNetwork(
      assetName,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorImage: errorImage,
    );
  }

  static SvgPicture _buildSvg(String assetName,
      {Key key = const Key(""),
      double width = 0,
      double height = 0,
      BoxFit fit = BoxFit.none,
      Color color = AppColors.completeTransparent}) {
    if (width == 0 && height == 0) {
      return SvgPicture.asset(
        assetName,
        fit: fit,
        color: color,
      );
    } else if (width == 0) {
      return SvgPicture.asset(
        assetName,
        height: height,
        fit: fit,
        color: color,
      );
    } else if (height == 0) {
      return SvgPicture.asset(
        assetName,
        width: width,
        fit: fit,
        color: color,
      );
    } else {
      return SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    }
  }

  static Widget _buildImageAsset(String assetName,
      {Key key = const Key(""),
      double width = 0,
      double height = 0,
      BoxFit fit = BoxFit.none}) {
    if (width == 0 && height == 0) {
      return Image.asset(
        assetName,
        fit: fit,
      );
    } else if (width == 0) {
      return Image.asset(
        assetName,
        height: height,
        fit: fit,
      );
    } else if (height == 0) {
      return Image.asset(
        assetName,
        width: width,
        fit: fit,
      );
    } else {
      return Image.asset(
        assetName,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  static Widget _buildImageNetwork(
    String url, {
    Key key = const Key(""),
    double width = 0,
    double height = 0,
    BoxFit fit = BoxFit.none,
    Color color = AppColors.completeTransparent,
    String errorImage = "",
  }) {
    return CachedNetworkImage(
      placeholder: (context, url) => const CircularProgressIndicator(),
      imageUrl: url,
    );
  }
}
