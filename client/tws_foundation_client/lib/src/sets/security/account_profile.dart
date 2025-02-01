import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AccountProfile implements CSMEncodeInterface {
  /// [account] property key.
  static const String kAccount = "account";

  /// [profile] property key.
  static const String kProfile = "profile";

  /// [accountNavigation] property key.
  static const String kAccountNavigation = "AccountNavigation";

  /// [permitNavigation] property key.
  static const String kProfileNavigation = "ProfileNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Foreign relation [Account] pointer.
  int account = 0;

  /// Foreign relation [Permit] pointer.
  int profile = 0;

  /// Foreign relation [accountNavigation] record entity.
  Account? accountNavigation;

  /// Foreign relation [profileNavigation] record entity.
  Profile? profileNavigation;

  AccountProfile(
    this.account,
    this.profile,
    this.accountNavigation,
    this.profileNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  AccountProfile.a();

  /// Creates an [AccountProfile] object based on a serealized JSON.
  factory AccountProfile.des(JObject json) {
    DateTime timestamp = json.get(SCK.kTimestamp);

    int account = json.get(kAccount);
    int permit = json.get(kProfile);
   
    Account? accountNavigation;
    if (json[kAccountNavigation] != null) {
      JObject rawNavigation = json.getDefault(kAccountNavigation, <String, dynamic>{});
      accountNavigation = Account.des(rawNavigation);
    }

    Profile? profileNavigation;
    if (json[kProfileNavigation] != null) {
      JObject rawNavigation = json.getDefault(kProfileNavigation, <String, dynamic>{});
      profileNavigation = Profile.des(rawNavigation);
    }
        
    return AccountProfile(account, permit, accountNavigation, profileNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      kAccount: account,
      kProfile: profile,
      kAccountNavigation: accountNavigation?.encode(),
      kProfileNavigation: profileNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }

  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(account < 0) results.add(CSMSetValidationResult(kAccount, '$kAccount pointer cannot be less than 0', 'pointerHandler()'));
    if(profile < 0) results.add(CSMSetValidationResult(kProfile, '$kProfile pointer cannot be less than 0', 'pointerHandler()'));
    if(accountNavigation != null) results = <CSMSetValidationResult>[...results, ...accountNavigation!.evaluate()];
    if(profileNavigation != null) results = <CSMSetValidationResult>[...results, ...profileNavigation!.evaluate()];

    return results;
  }

  /// Creates an [AccountProfile] overriding the given properties.
  AccountProfile clone({
    int? account,
    int? profile,
    Account? accountNavigation,
    Profile? profileNavigation,
  }){

    if(account == 0){
      this.accountNavigation = null;
      accountNavigation = null;
    }

    if(profile == 0){
      this.profileNavigation = null;
      profileNavigation = null;
    }
    
    return AccountProfile(
      account ?? this.account,
      profile ?? this.profile,
      accountNavigation ?? this.accountNavigation,
      profileNavigation ?? this.profileNavigation,
    );
  }
}
