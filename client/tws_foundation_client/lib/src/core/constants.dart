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

  /// internal edge property key for [DataMap].
  static const String kInternal = "internal"; 

  /// external edge property key for [DataMap].
  static const String kExternal = "external"; 

  static const String kReference = "reference"; 


}
