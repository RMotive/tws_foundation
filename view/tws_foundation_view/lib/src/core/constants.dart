import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;

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
///
/// Stores {foundation} handled routes for {foundation view} configurations.
final class FoundationRoutes {
  /// (Login Page) Default [FoundationSecureView] route where the user must authenticate.
  static const Route authRoute = Route(
    '',
    name: 'Login Page',
  );

  //! --> Employee Routes

  /// (Employees Entity Page) route.
  static const Route employeesPageRoute = Route(
    'employees',
    name: 'Employees Page',
  );

  /// (Employees Create Whisper) route.
  static const Route employeesCreateWhisperRoute = Route(
    'create-employees',
    name: 'Employees Creation',
  );

  //! <-- Employee Routes

  //! --> YardLogs Routes

  /// (YardLogs Entity Page) route.
  static const Route yardlogsPageRoute = Route(
    'yardlogs',
    name: 'YardLogs Page',
  );

  /// (YardLogs Create Whisper) route.
  static const Route yardlogsCreateWhisperRoute = Route(
    'create-yardlogs',
    name: 'YardLogs Creation',
  );

  //! <--- YardLogs Routes

  //! --> Drivers Routes

  static const Route driversPageRoute = Route(
    'drivers',
    name: 'Drivers Page',
  );

  static const Route driversCreateWhisperRoute = Route(
    'create-drivers',
    name: 'Drivers Creation',
  );

  //! <-- Drivers Routes

  //! --> Trucks Routes

  static const Route trucksPageRoute = Route(
    'trucks',
    name: 'Trucks Page',
  );

  static const Route trucksCreateWhisperRoute = Route(
    'create-trucks',
    name: 'Trucks Creation',
  );
  
  //! <-- Trucks Routes
}

/// {constant} class.
final class FoundationAssets {
  ///
  static const String _packagePath = 'packages/tws_foundation_view';

  ///
  static const String _businessPath = '$_packagePath/assets/business';

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
