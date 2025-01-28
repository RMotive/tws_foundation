import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

// Driver set information object.
final class Driver implements CSMSetInterface {
  /// [Employee] key property.
  static const String kEmployee = "employee";

  /// [DriverCommon] key property.
  static const String kCommon = "common";

  /// [driverType] key property.
  static const String kDriverType = "driverType";

  /// [licenseExpiration] key property.
  static const String kLicenseExpiration = "licenseExpiration";

  /// [drugalcRegistrationDate] key property.
  static const String kDrugalcRegistrationDate = "drugalcRegistrationDate";

  /// [pullnoticeRegistrationDate] key property.
  static const String kPullnoticeRegistrationDate = "pullnoticeRegistrationDate";

  /// [twic] property key.
  static const String kTwic = "twic";

  /// [twicExpiration] property key.
  static const String kTwicExpiration = "twicExpiration";

  /// [visa] property key.
  static const String kVisa = "visa";

  /// [visaExpiration] property key.
  static const String kVisaExpiration = "visaExpiration";

  /// [fast] property key.
  static const String kFast = "fast";

  /// [fastExpiration] property key.
  static const String kFastExpiration = "fastExpiration";

  /// [anam] property key.
  static const String kAnam = "anam";

  /// [anamExpiration] property key.
  static const String kAnamExpiration = "anamExpiration";

  /// [driverCommonNavigation] property key.
  static const String kDriverCommonNavigation = "DriverCommonNavigation";

  /// [employeeNavigation] property key.
  static const String kEmployeeNavigation = "EmployeeNavigation";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreing relation [Status] pointer.
  int status = 1;

  /// Foreign relation [Employee] pointer.
  int employee = 0;

  /// Foreign relation [DriverCommon] pointer.
  int common = 0;

  /// the type  category for this driver.
  String? driverType;

  /// Licence expiration date.
  DateTime? licenseExpiration;

  ///
  DateTime? drugalcRegistrationDate;

  ///
  DateTime? pullnoticeRegistrationDate;

  /// TWIC number.
  String? twic;

  /// TWIC expiration date.
  DateTime? twicExpiration;

  /// VISA number.
  String? visa;

  /// VISA expiration date.
  DateTime? visaExpiration;

  /// FAST number.
  String? fast;

  /// FAST expiration date.
  DateTime? fastExpiration;

  /// ANAM number.
  String? anam;

  /// ANAM expiration.
  DateTime? anamExpiration;

  /// [DriverCommon] navigation set.
  DriverCommon? driverCommonNavigation;

  /// [Employee] navigation set.
  Employee? employeeNavigation;

  /// [Status] navigation set.
  Status? statusNavigation;

  /// Creates an [Driver] object with default values.
  Driver.a(){
    _timestamp = DateTime.now();
  }

  /// Creates an [Driver] object with required parameters.
  Driver(
    this.id,
    this.status,
    this.employee,
    this.common,
    this.driverType,
    this.licenseExpiration,
    this.drugalcRegistrationDate,
    this.pullnoticeRegistrationDate,
    this.twic,
    this.twicExpiration,
    this.visa,
    this.visaExpiration,
    this.fast,
    this.fastExpiration,
    this.anam,
    this.anamExpiration,
    this.driverCommonNavigation,
    this.employeeNavigation,
    this.statusNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Creates and [Driver] based on a serialized JSON object.
  factory Driver.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int employee = json.get(kEmployee);
    int common = json.get(kCommon);
    String? driverType = json.getDefault(kDriverType, null);
    DateTime timestamp = json.get(SCK.kTimestamp);

    String? licenExp = json.getDefault(kLicenseExpiration, null);
    DateTime? licenseExpiration =
        licenExp != null ? DateTime.parse(licenExp) : null;

    String? drugal = json.getDefault(kDrugalcRegistrationDate, null);
    DateTime? drugalcRegistrationDate =
        drugal != null ? DateTime.parse(drugal) : null;

    String? pullnotice = json.getDefault(kPullnoticeRegistrationDate, null);
    DateTime? pullnoticeRegistrationDate =
        pullnotice != null ? DateTime.parse(pullnotice) : null;

    String? twic = json.getDefault(kTwic, null);

    String? twicEx = json.getDefault(kTwicExpiration, null);
    DateTime? twicExpiration = twicEx != null ? DateTime.parse(twicEx) : null;

    String? visa = json.getDefault(kVisa, null);

    String? visaExp = json.getDefault(kVisaExpiration, null);
    DateTime? visaExpiration = visaExp != null ? DateTime.parse(visaExp) : null;

    String? fast = json.getDefault(kFast, null);

    String? fastExp = json.getDefault(kFastExpiration, null);
    DateTime? fastExpiration = fastExp != null ? DateTime.parse(fastExp) : null;

    String? anam = json.getDefault(kAnam, null);

    String? anamExp = json.getDefault(kAnamExpiration, null);
    DateTime? anamExpiration = anamExp != null ? DateTime.parse(anamExp) : null;

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation =
          json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    DriverCommon? driverCommonNavigation;
    if (json[kDriverCommonNavigation] != null) {
      JObject rawNavigation =
          json.getDefault(kDriverCommonNavigation, <String, dynamic>{});
      driverCommonNavigation = DriverCommon.des(rawNavigation);
    }

    Employee? employeeNavigation;
    if (json[kEmployeeNavigation] != null) {
      JObject rawNavigation =
          json.getDefault(kEmployeeNavigation, <String, dynamic>{});
      employeeNavigation = Employee.des(rawNavigation);
    }

    return Driver(
      id,
      status,
      employee,
      common,
      driverType,
      licenseExpiration,
      drugalcRegistrationDate,
      pullnoticeRegistrationDate,
      twic,
      twicExpiration,
      visa,
      visaExpiration,
      fast,
      fastExpiration,
      anam,
      anamExpiration,
      driverCommonNavigation,
      employeeNavigation,
      statusNavigation,
      timestamp: timestamp,
    );
  }

  @override
  JObject encode() {
    String? a = licenseExpiration?.toString().substring(0, 10);
    String? b = drugalcRegistrationDate?.toString().substring(0, 10);
    String? c = pullnoticeRegistrationDate?.toString().substring(0, 10);
    String? d = twicExpiration?.toString().substring(0, 10);
    String? e = visaExpiration?.toString().substring(0, 10);
    String? f = fastExpiration?.toString().substring(0, 10);
    String? g = anamExpiration?.toString().substring(0, 10);

    return <String, dynamic>{
      'id': id,
      SCK.kStatus: status,
      kEmployee: employee,
      kCommon: common,
      kDriverType: driverType,
      kLicenseExpiration: a,
      kDrugalcRegistrationDate: b,
      kPullnoticeRegistrationDate: c,
      kTwic: twic,
      kTwicExpiration: d,
      kVisa: visa,
      kVisaExpiration: e,
      kFast: fast,
      kFastExpiration: f,
      kAnam: anam,
      kAnamExpiration: g,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kEmployeeNavigation: employeeNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (driverType != null) {
      if (driverType!.trim().isEmpty || driverType!.length > 16) results.add(CSMSetValidationResult(kDriverType, 'Driver Type length must be between 1 and 16', 'strictLength(1,16)'));
    }

    if (twic != null) {
      if (twic!.trim().isEmpty || twic!.length != 12) results.add(CSMSetValidationResult(kTwic, 'TWIC length must be 12', 'strictLength(12)'));
    }

    if (visa != null) {
      if (visa!.trim().isEmpty || visa!.length != 12) results.add(CSMSetValidationResult(kVisa, 'Kvisa length must be 12', 'strictLength(12)'));
    }

    if (fast != null) {
      if (fast!.trim().isEmpty || fast!.length != 14) results.add(CSMSetValidationResult(kFast, 'FAST length must be 14', 'strictLength(14)'));
    }

    if (anam != null) {
      if (anam!.trim().isEmpty || anam!.length != 24) results.add(CSMSetValidationResult(kAnam, 'ANAM length must be 24', 'strictLength(24)'));
    }

    if (twicExpiration != null && twic == null) results.add(CSMSetValidationResult('$kTwicExpiration & $kTwic' , 'TWIC number must be provided if the TWIC expiration date is selected.', 'fieldConflict()'));
    if (visaExpiration != null && visa == null) results.add(CSMSetValidationResult('$kVisaExpiration & $kVisa' , 'VISA number must be provided if the VISA expiration date is selected.', 'fieldConflict()'));
    if (fastExpiration != null && fast == null) results.add(CSMSetValidationResult('$kFastExpiration & $kFast' , 'FAST number must be provided if the FAST expiration date is selected.', 'fieldConflict()'));
    if (anamExpiration != null && anam == null) results.add(CSMSetValidationResult('$kAnam & $kAnam' , 'ANAM number must be provided if the ANAM expiration date is selected.', 'fieldConflict()'));

    if (employee <= 0 && employeeNavigation == null) results.add(CSMSetValidationResult(kEmployee, 'Debe ingresar los datos del empleado. Employee pointer must be equal or greater than 0', 'pointerHandler()'));
    if (common <= 0 && driverCommonNavigation == null) results.add(CSMSetValidationResult(kCommon, 'Debe ingresar los datos comunes del conductor. Common pointer must be equal or greater than 0','pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if (driverCommonNavigation != null)  results = <CSMSetValidationResult>[...results, ...driverCommonNavigation!.evaluate()];
    if (employeeNavigation != null) results = <CSMSetValidationResult>[...results, ...employeeNavigation!.evaluate()];

    return results;
  }

  /// Creates a clone for a [Driver] object, overriding the given values.
  Driver clone({
    int? id,
    int? status,
    int? employee,
    int? common,
    String? driverType,
    DateTime? licenseExpiration,
    DateTime? drugalcRegistrationDate,
    DateTime? pullnoticeRegistrationDate,
    String? twic,
    DateTime? twicExpiration,
    String? visa,
    DateTime? visaExpiration,
    String? fast,
    DateTime? fastExpiration,
    String? anam,
    DateTime? anamExpiration,
    DriverCommon? driverCommonNavigation,
    Employee? employeeNavigation,
    Status? statusNavigation,
  }) {

    if(employee == 0){
      this.employeeNavigation = null;
      employeeNavigation = null;
    }

    if(driverType != null){
      if(driverType.trim().isEmpty){
        driverType = null;
        this.driverType = null;
      }
    }

     if(twic != null){
      if(twic.trim().isEmpty){
        twic = null;
        this.twic = null;
      }
    }

    if(visa != null){
      if(visa.trim().isEmpty){
        visa = null;
        this.visa = null;
      }
    }

    if(fast != null){
      if(fast.trim().isEmpty){
        fast = null;
        this.fast = null;
      }
    }

    if(anam != null){
      if(anam.trim().isEmpty){
        anam = null;
        this.anam = null;
      }
    }

    if(licenseExpiration == DateTime(0)){
      this.licenseExpiration = null;
      licenseExpiration = null;
    }

    if(drugalcRegistrationDate == DateTime(0)){
      this.drugalcRegistrationDate = null;
      drugalcRegistrationDate = null;
    }

    if(pullnoticeRegistrationDate == DateTime(0)){
      this.pullnoticeRegistrationDate = null;
      pullnoticeRegistrationDate = null;
    }

    if(twicExpiration == DateTime(0)){
      this.twicExpiration = null;
      twicExpiration = null;
    } 

    if(visaExpiration == DateTime(0)){
      this.visaExpiration = null;
      visaExpiration = null;
    } 
    
    if(fastExpiration == DateTime(0)){
      this.fastExpiration = null;
      fastExpiration = null;
    }

    if(anamExpiration == DateTime(0)){
      this.anamExpiration = null;
      anamExpiration = null;
    }

    return Driver(
      id ?? this.id,
      status ?? this.status,
      employee ?? this.employee,
      common ?? this.common,
      driverType ?? this.driverType,
      licenseExpiration ?? this.licenseExpiration,
      drugalcRegistrationDate ?? this.drugalcRegistrationDate,
      pullnoticeRegistrationDate ?? this.pullnoticeRegistrationDate,
      twic ?? this.twic,
      twicExpiration ?? this.twicExpiration,
      visa ?? this.visa,
      visaExpiration ?? this.visaExpiration,
      fast ?? this.fast,
      fastExpiration ?? this.fastExpiration,
      anam ?? this.anam,
      anamExpiration ?? this.anamExpiration,
      driverCommonNavigation ?? this.driverCommonNavigation,
      employeeNavigation ?? this.employeeNavigation,
      statusNavigation ?? this.statusNavigation,
    );
  }
}
