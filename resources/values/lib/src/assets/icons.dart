// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAssets {
  const IconAssets();

  static const baseIconPath = 'assets/icons/';

  SvgGeneralImage get circleDoneIcon =>
      const SvgGeneralImage('${baseIconPath}circle_done_icon.svg');

  SvgGeneralImage get copyIcon =>
      const SvgGeneralImage('${baseIconPath}copy_icon.svg');

  SvgGeneralImage get personIcon =>
      const SvgGeneralImage('${baseIconPath}person_icon.svg');

  SvgGeneralImage get decimalIcon =>
      const SvgGeneralImage('${baseIconPath}decimal_icon.svg');

  SvgGeneralImage get deleteIcon =>
      const SvgGeneralImage('${baseIconPath}delete_icon.svg');

  SvgGeneralImage get payIcon =>
      const SvgGeneralImage('${baseIconPath}pay_icon.svg');

  SvgGeneralImage get discoverIcon =>
      const SvgGeneralImage('${baseIconPath}discover_icon.svg');

  SvgGeneralImage get shareIcon =>
      const SvgGeneralImage('${baseIconPath}share_icon.svg');

  SvgGeneralImage get infoCircle =>
      const SvgGeneralImage('${baseIconPath}info_circle.svg');

  SvgGeneralImage get errorIcon =>
      const SvgGeneralImage('${baseIconPath}error_icon.svg');

  SvgGeneralImage get outlineDoneIcon =>
      const SvgGeneralImage('${baseIconPath}outline_done_icon.svg');

  SvgGeneralImage get outlineErrorIcon =>
      const SvgGeneralImage('${baseIconPath}outline_error_icon.svg');

  SvgGeneralImage get warningIcon =>
      const SvgGeneralImage('${baseIconPath}warning_icon.svg');

  SvgGeneralImage get top3Logo =>
      const SvgGeneralImage('${baseIconPath}top3_logo.svg');

  SvgGeneralImage get nfcMobileIcon =>
      const SvgGeneralImage('${baseIconPath}nfc_mobile_icon.svg');

  SvgGeneralImage get qrIcon =>
      const SvgGeneralImage('${baseIconPath}qr_icon.svg');

  SvgGeneralImage get moreIcon =>
      const SvgGeneralImage('${baseIconPath}more_icon.svg');

  /// List of all assets
  List<SvgGeneralImage> get values => [
        circleDoneIcon,
        errorIcon,
        outlineDoneIcon,
        outlineErrorIcon,
        warningIcon,
        top3Logo,
        nfcMobileIcon,
        qrIcon,
        moreIcon,
        infoCircle
      ];
}

class SvgGeneralImage {
  const SvgGeneralImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Color? color,
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: 'values',
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
