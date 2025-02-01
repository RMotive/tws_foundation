import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AccountPermit implements CSMEncodeInterface {
  /// [account] property key.
  static const String kAccount = "account";

  /// [permit] property key.
  static const String kPermit = "permit";

  /// [accountNavigation] property key.
  static const String kAccountNavigation = "AccountNavigation";

  /// [permitNavigation] property key.
  static const String kPermitNavigation = "PermitNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Foreign relation [Account] pointer.
  int account = 0;

  /// Foreign relation [Permit] pointer.
  int permit = 0;

  /// Foreign relation [accountNavigation] record entity.
  Account? accountNavigation;

  /// Foreign relation [permitNavigation] record entity.
  Permit? permitNavigation;

  AccountPermit(
    this.account,
    this.permit,
    this.accountNavigation,
    this.permitNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  AccountPermit.a(); 
  
  /// Creates an [AccountPermit] object based on a serealized JSON.
  factory AccountPermit.des(JObject json) {
    DateTime timestamp = json.get(SCK.kTimestamp);

    int account = json.get(kAccount);
    int permit = json.get(kPermit);
   
    Account? accountNavigation;
    if (json[kAccountNavigation] != null) {
      JObject rawNavigation = json.getDefault(kAccountNavigation, <String, dynamic>{});
      accountNavigation = Account.des(rawNavigation);
    }

    Permit? permitNavigation;
    if (json[kPermitNavigation] != null) {
      JObject rawNavigation = json.getDefault(kPermitNavigation, <String, dynamic>{});
      permitNavigation = Permit.des(rawNavigation);
    }
        
    return AccountPermit(account, permit, accountNavigation, permitNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      kAccount: account,
      kPermit: permit,
      kAccountNavigation: accountNavigation?.encode(),
      kPermitNavigation: permitNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }

  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(account < 0) results.add(CSMSetValidationResult(kAccount, '$kAccount pointer cannot be less than 0', 'pointerHandler()'));
    if(permit < 0) results.add(CSMSetValidationResult(kPermit, '$kPermit pointer cannot be less than 0', 'pointerHandler()'));
    if(accountNavigation != null) results = <CSMSetValidationResult>[...results, ...accountNavigation!.evaluate()];
    if(permitNavigation != null) results = <CSMSetValidationResult>[...results, ...permitNavigation!.evaluate()];

    return results;
  }

  /// Creates an [AccountPermit] overriding the given properties.
  AccountPermit clone({
    int? account,
    int? permit,
    Account? accountNavigation,
    Permit? permitNavigation,
  }){

    if(account == 0){
      this.accountNavigation = null;
      accountNavigation = null;
    }

    if(permit == 0){
      this.permitNavigation = null;
      permitNavigation = null;
    }
    
    return AccountPermit(
      account ?? this.account,
      permit ?? this.permit,
      accountNavigation ?? this.accountNavigation,
      permitNavigation ?? this.permitNavigation,
    );
  }
}
