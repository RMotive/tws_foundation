import 'package:flutter/material.dart';

/// {constant} class.
///
/// Stores {TWS} specific business [Color]s information.
final class FoundationColors {
  static const Color lightDark = Color(0xff343635);
  static const Color darkGrey = Color(0xff525254);
  static const Color ligthGrey = Color(0xff878888);
  static const Color deepPurple = Color(0xff1b1c24);
  static const Color warmWhite = Color(0xffdddddd);

  static const Color oceanBlue = Color(0xff04548c);
  static const Color oceanBlueH = Color(0x8804548c);

  static const Color deepWine = Color(0xff731015);
  static const Color smoothWine = Color(0xffca524a);
}

///
final class FoundationAssets {
  ///
  static const String _businessPath = 'assets/business';

  ///
  static const String businessIcon = '$_businessPath/business_icon.webp';

  ///
  static const String fullLogoBlackPng = '$_businessPath/full_logo_black.png';

  ///
  static const String fullLogoBlackWebp = '$_businessPath/full_logo_black.webp';

  ///
  static const String fullLogoWhitePng = '$_businessPath/full_logo_white.png';

  ///
  static const String fullLogoWhiteWebp = '$_businessPath/full_logo_white.webp';

  ///
  static const String wideLogoBlackPng = '$_businessPath/wide_logo_black.png';

  ///
  static const String wideLogoBlackWebp = '$_businessPath/wide_logo_black.webp';

  ///
  static const String wideLogoWhitePng = '$_businessPath/wide_logo_white.png';

  ///
  static const String wideLogoWhiteWebp = '$_businessPath/wide_logo_white.webp';
}

///
final class FoundationMessages {
  ///
  static const String stateManagementError =
      'Unexpected state management error, contact support.';

  ///
  static const String emptyInputError = 'Cannot be empty.';
}
