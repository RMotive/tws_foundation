import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
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
  /// Length must be 1 to 12 characters.
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
    List<EntityInvalidation<Driver>> invalidations = <EntityInvalidation<Driver>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if ((fast!.trim().isEmpty || fast!.length != 24)) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kFast, String, fast),
          'Lenght must be 24 characters',
          'strictLength(24)',
        ),
      );
    }

    if ((twic!.trim().isEmpty || twic!.length != 12)) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kTwic, String, twic),
          'Lenght must be 12 characters',
          'strictLength(12)',
        ),
      );
    }

    if ((visa!.trim().isEmpty || visa!.length != 24)) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kVisa, String, visa),
          'Lenght must be 24 characters',
          'strictLength(24)',
        ),
      );
    }

    if ((anam!.trim().isEmpty || anam!.length != 24)) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kAnam, String, anam),
          'Lenght must be 24 characters',
          'strictLength(24)',
        ),
      );
    }

    if ((driverType!.trim().isEmpty || driverType!.length != 12)) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kDriverType, String, driverType),
          'Lenght must be 12 characters',
          'strictLength(12)',
        ),
      );
    }
    if(twicExpiration != null && twic == null) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kTwicExpiration, DateTime, twicExpiration),
          'Twic expiration date cannot be set if TWIC is not set',
          'fieldConflict()',
        ),
      );
    }

    if(visaExpiration != null && visa == null) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kVisaExpiration, DateTime, visaExpiration),
          'Visa expiration date cannot be set if VISA is not set',
          'fieldConflict()',
        ),
      );
    }

    if(fastExpiration != null && fast == null) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kFastExpiration, DateTime, fastExpiration),
          'Fast expiration date cannot be set if FAST is not set',
          'fieldConflict()',
        ),
      );
    }

    if(anamExpiration != null && anam == null) {
      invalidations.add(
        EntityInvalidation<Driver>(
          this,
          PropertyInfo(kAnamExpiration, DateTime, anamExpiration),
          'Anam expiration date cannot be set if ANAM is not set',
          'fieldConflict()',
        ),
      );
    }

    invalidations.validateDependency(this, employee);

   return invalidations;
  }
}
