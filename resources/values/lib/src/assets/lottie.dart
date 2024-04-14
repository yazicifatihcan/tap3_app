// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAssets {
  const LottieAssets();

  static const baseLottiePath = 'assets/lottie/';

  LottieGeneralImage get nfcAnimation => const LottieGeneralImage(
        '${baseLottiePath}nfc_animation.json',
      );

  LottieGeneralImage get successAnimation => const LottieGeneralImage(
        '${baseLottiePath}success_animation.json',
      );

  /// List of all assets
  List<LottieGeneralImage> get values => [
        nfcAnimation,
      ];
}

class LottieGeneralImage {
  const LottieGeneralImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Key? key,
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    AssetBundle? bundle,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
  }) {
    return LottieBuilder.asset(
      _assetName,
      controller: controller,
      frameRate: frameRate,
      animate: animate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      imageProviderFactory: imageProviderFactory,
      onLoaded: onLoaded,
      key: key,
      bundle: bundle,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: 'values',
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
