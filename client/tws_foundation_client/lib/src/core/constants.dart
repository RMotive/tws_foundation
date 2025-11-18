import 'package:csm_client/csm_client.dart';

///
final class ContextConstants {
  static String sign = "TWSMF";
}

/// {constants} class.
/// 
/// Stores constant values for {foundation} common properties access keys.
final class FoundationCommonPropertyKeys {
  /// status property key for [DataMap].
  static const String kStatus = "status";

  /// situation property key for [DataMap].
  static const String kSituation = "situation";

  /// sct property key for [DataMap].
  static const String kSCT = "sct"; 
  
}

/// {constant} class.
/// 
/// Stores {foundation_server} handled references for {foundation view} configurations.
final class FoundationReferences{
  //* --> Load types references.
  static const String loadTypeBotado = "botad001";
  static const String loadTypeloaded = "loded002";
  static const String loadTypeEmpty = "empty003";
  //* <-- Load types references.


  //* --> Status references.
  static const String statusActive = "actve001";

  //* --> Resources references.

  /// Reference for truck front evidence resource.
  static const String truckFrontRes = "tckFnt01";

  /// Reference for truck lateral evidence resource.
  static const String truckLateralRes = "tckLat01";

  /// Reference for trailer lateral evidence resource.
  static const String trailerLateralRes = "tlrLat01";

  /// Reference for trailer back evidence resource.
  static const String trailerBackRes= "tlrBck01";

  // --> Reference for damage evidence resources.
  static const String damage1Res = "dmg01";
  static const String damage2Res = "dmg02";

  // --> Reference for trailer seals resources.
  static const String seal1Res = 'seal01';
  static const String seal2Res = 'seal02';

  //* <-- Resources references.
  
}
