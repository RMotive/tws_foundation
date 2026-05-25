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

/// {constant} class.
final class FoundationAssets {
  ///
  static const String _packagePath = 'packages/tws_foundation_view';

  ///
  static const String _businessPath = '$_packagePath/assets/business';

  ///
  static const String _entriesPath = '$_packagePath/assets/entries';

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

  ///
  static const String damagedSvg = '$_businessPath/damaged.svg';

  ///
  static const String exitSvg = '$_businessPath/exit.svg';

  ///
  static const String trailerBackSvg = '$_businessPath/trailer_back.svg';

  ///
  static const String trailerLateralSvg = '$_businessPath/trailer_lateral.svg';

  ///
  static const String truckFrontSvg = '$_businessPath/truck_front.svg';

  ///
  static const String truckLateralSvg = '$_businessPath/truck_lateral.svg';

  ///
  static const String truckEmptySvg = '$_businessPath/truck_empty.svg';
  
  ///
  static const String truckBobtailingSvg = '$_businessPath/truck_bobtailing.svg';

  ///
  static const String truckLoadedSvg = '$_businessPath/truck_loaded.svg';

  ///
  static const String sealSvg = '$_businessPath/seal.svg';

  ///
  static const String yardPlaceholderSvg = '$_businessPath/yard_placeholder.svg';

  static const String yardSectionWestEmptyDryVan = '$_businessPath/yard_section_west_empty_dry_van_trailers.svg';

  //! --> Preview Assests
  ///
  static const String categoryPagePreview = '$_entriesPath/category_page_preview.png';

  ///
  static const String pagePreview = '$_entriesPath/page_preview.png';

  ///
  static const String tablePreview = '$_entriesPath/table_preview.png';

  //! <--- Preview Assets

}

/// {constant} class.
final class FoundationMessages {
  ///
  static const String stateManagementError = 'Unexpected state management error, contact support.';

  ///
  static const String emptyInputError = 'Cannot be empty.';

  ///
  static const String connectionError = 'Unable to connect with server, contact administration support.';

  ///
  static const String unknownServerException = '(critical) Server error, contact administration support.';
}
