import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
///
final class Driver extends EntityB<Driver> {
  /// [Driver.employee] property key for [DataMap].
  static const String kEmployee = "employee";

  /// [Driver.driverType] property key for [DataMap].
  static const String kDriverType = "driverType";

  /// [Driver.licenseExpiration] property key for [DataMap].
  static const String kLicenseExpiration = "licenseExpiration";

  /// [Driver.drugAlcRegistrationDate] property key for [DataMap].
  static const String kDrugalcRegistrationDate = "drugalcRegistrationDate";

  /// [Driver.pullNoticeRegistrationDate] property key for [DataMap].
  static const String kPullnoticeRegistrationDate = "pullnoticeRegistrationDate";

  /// [Driver.twic] property key for [DataMap].
  static const String kTwic = "twic";

  /// [Driver.twicExpiration] property key for [DataMap].
  static const String kTwicExpiration = "twicExpiration";

  /// [Driver.visa] property key for [DataMap].
  static const String kVisa = "visa";

  /// [Driver.visaExpiration] property key for [DataMap].
  static const String kVisaExpiration = "visaExpiration";

  /// [Driver.fast] property key for [DataMap].
  static const String kFast = "fast";

  /// [Driver.fastExpiration] property key for [DataMap].
  static const String kFastExpiration = "fastExpiration";

  /// [Driver.anam] property key for [DataMap].
  static const String kAnam = "anam";

  /// [Driver.anamExpiration] property key for [DataMap].
  static const String kAnamExpiration = "anamExpiration";

  //! --> Properties

  /// "Fast" permit number.
  ///
  /// Length must be 24
  String? fast;

  /// TODO: Define.
  ///
  /// Length must be 24
  String? anam;

  /// USA visa document number.
  ///
  /// Length must be 24.
  String? visa;

  /// TODO: Define.
  ///
  /// Length must be 12.
  String? twic;

  /// TODO: Define.
  ///
  /// Length must be 12.
  String? driverType;

  /// Driver's license expiration date.
  DateTime? licenseExpiration;

  /// TODO: Define.
  DateTime? drugAlcRegistrationDate;

  /// TODO: Define.
  DateTime? pullNoticeRegistrationDate;

  /// TODO: Define.
  DateTime? twicExpiration;

  /// USA visa expiration date.
  DateTime? visaExpiration;

  /// "fast" permit expiration date.
  DateTime? fastExpiration;

  /// TODO: Define.
  DateTime? anamExpiration;

  //! <-- Properties

  //! --> Relations

  /// [Employee] information.
  Employee employee = Employee();

  //! <-- Relations

  /// Creates a new [Driver] instance.
  Driver();

  @override
  void decode(DataMap encode) {
    fast = encode.get(kFast);
    anam = encode.get(kAnam);
    visa = encode.get(kVisa);
    twic = encode.get(kTwic);
    driverType = encode.get(kDriverType);
    licenseExpiration = encode.get(kLicenseExpiration);
    drugAlcRegistrationDate = encode.get(kDrugalcRegistrationDate);
    pullNoticeRegistrationDate = encode.get(kPullnoticeRegistrationDate);
    twicExpiration = encode.get(kTwicExpiration);
    visaExpiration = encode.get(kVisaExpiration);
    fastExpiration = encode.get(kFastExpiration);
    anamExpiration = encode.get(kAnamExpiration);

    employee = encode.getEntity(() => Employee(), kEmployee) ?? employee;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kFast: fast,
        kAnam: anam,
        kVisa: visa,
        kTwic: twic,
        kDriverType: driverType,
        kLicenseExpiration: licenseExpiration?.toIso8601String(),
        kDrugalcRegistrationDate: drugAlcRegistrationDate?.toIso8601String(),
        kPullnoticeRegistrationDate: pullNoticeRegistrationDate?.toIso8601String(),
        kTwicExpiration: twicExpiration?.toIso8601String(),
        kVisaExpiration: visaExpiration?.toIso8601String(),
        kFastExpiration: fastExpiration?.toIso8601String(),
        kAnamExpiration: anamExpiration?.toIso8601String(),
        kEmployee: employee.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Driver>> evaluate() {
    return <EntityInvalidation<Driver>>[];
  }
}
