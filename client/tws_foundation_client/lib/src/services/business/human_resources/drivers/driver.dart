import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
///
final class Driver extends EntityBase<Driver> {
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
  /// Length must be 12
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
    Status status = Status();
    Situation situation = Situation();
    status.reference = 'referdef';
    situation.reference = 'referdef';
    
    DriverCommon common = DriverCommon.a("licenseDef", status, situation);
    return super.encode(
      <String, Object?>{
        kFast: fast,
        kAnam: anam,
        kVisa: visa,
        kTwic: twic,
        kDriverType: driverType,
        kLicenseExpiration: licenseExpiration?.dateOnlyIso,
        kDrugalcRegistrationDate: drugAlcRegistrationDate?.dateOnlyIso,
        kPullnoticeRegistrationDate: pullNoticeRegistrationDate?.dateOnlyIso,
        kTwicExpiration: twicExpiration?.dateOnlyIso,
        kVisaExpiration: visaExpiration?.dateOnlyIso,
        kFastExpiration: fastExpiration?.dateOnlyIso,
        kAnamExpiration: anamExpiration?.dateOnlyIso,
        kEmployee: employee.encode(),
        'common': common.encode(),
      },
    );
  }

  @override
  List<EntityErrors<Driver>> evaluate(List<EntityErrors<Driver>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (fast != null && (fast!.trim().isEmpty || fast!.length != 12)) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kFast, String, fast),
          'Length: ${fast!.length}, must be empty or equal to 12 characters',
          'length == 0 || 13 > length >  11',
        ),
      );
    }

    if (twic != null && (twic!.trim().isEmpty || twic!.length != 12)) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kTwic, String, twic),
          'Length: ${twic!.length}, must be empty or equal to 12 characters',
          'length == 0 || 13 > length >  11',
        ),
      );
    }

    if (visa != null && (visa!.trim().isEmpty || visa!.length != 12)) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kVisa, String, visa),
          'Length: ${visa!.length}, must be empty or equal to 12 characters',
          'length == 0 || 13 > length >  11',
        ),
      );
    }

    if (anam != null && (anam!.trim().isEmpty || anam!.length != 24)) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kAnam, String, anam),
          'Length: ${anam!.length}, must be empty or equal to 24 characters',
          'length == 0 || 25 > length >  23',
        ),
      );
    }

    if (driverType != null && (driverType!.trim().isEmpty || driverType!.length != 12)) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kDriverType, String, driverType),
          'Length: ${driverType!.length}, must be empty or equal to 12 characters',
          'length == 0 || 13 > length >  11',
        ),
      );
    }
    if(twicExpiration != null && twic == null) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kTwicExpiration, DateTime, twicExpiration),
          'Twic expiration date cannot be set if TWIC is not set',
          'fieldConflict()',
        ),
      );
    }

    if(visaExpiration != null && visa == null) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kVisaExpiration, DateTime, visaExpiration),
          'Visa expiration date cannot be set if VISA is not set',
          'fieldConflict()',
        ),
      );
    }

    if(fastExpiration != null && fast == null) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kFastExpiration, DateTime, fastExpiration),
          'Fast expiration date cannot be set if FAST is not set',
          'fieldConflict()',
        ),
      );
    }

    if(anamExpiration != null && anam == null) {
      errors.add(
        EntityErrors<Driver>(
          this,
          PropertyInfo(kAnamExpiration, DateTime, anamExpiration),
          'Anam expiration date cannot be set if ANAM is not set',
          'fieldConflict()',
        ),
      );
    }

    errors.validateDependency(this, employee);

   return errors;
  }
  
  @override
  List<ObjectDifference> compare(Driver ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> employeeDiff = employee.compare(ref.employee);

    if (fast != ref.fast) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kFast, String, fast),
          fast,
          ref.fast,
          null,
        ),
      );
    }

    if (anam != ref.anam) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAnam, String, anam),
          anam,
          ref.anam,
          null,
        ),
      );
    }

    if (visa != ref.visa) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kVisa, String, visa),
          visa,
          ref.visa,
          null,
        ),
      );
    }

    if (twic != ref.twic) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kTwic, String, twic),
          twic,
          ref.twic,
          null,
        ),
      );
    }

    if (driverType != ref.driverType) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kDriverType, String, driverType),
          driverType,
          ref.driverType,
          null,
        )
      );
    }

    if (employeeDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEmployee, Employee, employee),
          employee,
          ref.employee,
          employeeDiff,
        ),
      );
    }

    if(anamExpiration != ref.anamExpiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAnamExpiration, DateTime, anamExpiration),
          anamExpiration,
          ref.anamExpiration,
          null,
        ),
      );
    }

    if(fastExpiration != ref.fastExpiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kFastExpiration, DateTime, fastExpiration),
          fastExpiration,
          ref.fastExpiration,
          null,
        ),
      );
    }

    if(visaExpiration != ref.visaExpiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kVisaExpiration, DateTime, visaExpiration),
          visaExpiration,
          ref.visaExpiration,
          null,
        ),
      );
    }

    if(twicExpiration != ref.twicExpiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kTwicExpiration, DateTime, twicExpiration),
          twicExpiration,
          ref.twicExpiration,
          null,
        ),
      );
    }

    if (licenseExpiration != ref.licenseExpiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kLicenseExpiration, DateTime, licenseExpiration),
          licenseExpiration,
          ref.licenseExpiration,
          null,
        ),
      );
    }

    if (drugAlcRegistrationDate != ref.drugAlcRegistrationDate) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kDrugalcRegistrationDate, DateTime, drugAlcRegistrationDate),
          drugAlcRegistrationDate,
          ref.drugAlcRegistrationDate,
          null,
        ),
      );
    }

    if (pullNoticeRegistrationDate != ref.pullNoticeRegistrationDate) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kPullnoticeRegistrationDate, DateTime, pullNoticeRegistrationDate),
          pullNoticeRegistrationDate,
          ref.pullNoticeRegistrationDate,
          null,
        ),
       );
    }

    return aggregated;
  }
}
