import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Driver implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kEmployee = "employee";
  static const String kCommon = "common";
  static const String kDriverType = "driverType";
  static const String kLicenseExpiration = "licenseExpiration";
  static const String kDrugalcRegistrationDate = "drugalcRegistrationDate";
  static const String kPullnoticeRegistrationDate = "pullnoticeRegistrationDate";
  static const String kTwic = "twic";
  static const String kTwicExpiration = "twicExpiration";
  static const String kVisa = "visa";
  static const String kVisaExpiration = "visaExpiration";
  static const String kFast = "fast";
  static const String kFastExpiration = "fastExpiration";
  static const String kAnam = "anam";
  static const String kAnamExpiration = "anamExpiration";
  static const String kDriverCommonNavigation = "driverCommonNavigation";
  static const String kEmployeeNavigation = "employeeNavigation";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int employee = 0;
  int common = 0;
  String driverType = "";
  DateTime licenseExpiration = DateTime.now();
  DateTime drugalcRegistrationDate = DateTime.now();
  DateTime pullnoticeRegistrationDate = DateTime.now();
  String? twic;
  DateTime? twicExpiration;
  String? visa;
  DateTime? visaExpiration;
  String? fast;
  DateTime? fastExpiration;
  String? anam;
  DateTime? anamExpiration;
  DriverCommon? driverCommonNavigation;
  Employee? employeeNavigation;
  Status? statusNavigation;

  Driver(this.id, this.status, this.employee, this.common, this.driverType, this.licenseExpiration, this.drugalcRegistrationDate, this.pullnoticeRegistrationDate, this.twic, this.twicExpiration,
      this.visa, this.visaExpiration, this.fast, this.fastExpiration, this.anam, this.anamExpiration, this.driverCommonNavigation, this.employeeNavigation, this.statusNavigation);

  Driver.def();

  factory Driver.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int employee = json.get(kEmployee);
    int common = json.get(kCommon);
    String driverType = json.get(kDriverType);
    DateTime licenseExpiration = json.get(kLicenseExpiration);
    DateTime drugalcRegistrationDate = json.get(kDrugalcRegistrationDate);
    DateTime pullnoticeRegistrationDate = json.get(kPullnoticeRegistrationDate);
    String? twic = json.getDefault(kTwic, null);
    DateTime twicExpiration = json.get(kTwicExpiration);
    String? visa = json.getDefault(kVisa, null);
    DateTime visaExpiration = json.get(kVisaExpiration);
    String? fast = json.getDefault(kFast, null);
    DateTime fastExpiration = json.get(kFastExpiration);
    String? anam = json.getDefault(kAnam, null);
    DateTime anamExpiration = json.get(kAnamExpiration);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    DriverCommon? driverCommonNavigation;
    if (json[kDriverCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kDriverCommonNavigation, <String, dynamic>{});
      driverCommonNavigation = DriverCommon.des(rawNavigation);
    }

    Employee? employeeNavigation;
    if (json[kEmployeeNavigation] != null) {
      JObject rawNavigation = json.getDefault(kEmployeeNavigation, <String, dynamic>{});
      employeeNavigation = Employee.des(rawNavigation);
    }

    return Driver(id, status, employee, common, driverType, licenseExpiration, drugalcRegistrationDate, pullnoticeRegistrationDate, twic, twicExpiration, visa, visaExpiration, fast, fastExpiration,
        anam, anamExpiration, driverCommonNavigation, employeeNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    String a = licenseExpiration.toString().substring(0, 10);
    String b = drugalcRegistrationDate.toString().substring(0, 10);
    String c = pullnoticeRegistrationDate.toString().substring(0, 10);
    String? d = twicExpiration?.toString().substring(0, 10);
    String? e = visaExpiration?.toString().substring(0, 10);
    String? f = fastExpiration?.toString().substring(0, 10);
    String? g = anamExpiration?.toString().substring(0, 10);

    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
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
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kEmployeeNavigation: employeeNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (driverType.isEmpty || driverType.length > 12) results.add(CSMSetValidationResult(kDriverType, 'Driver Type length must be between 1 and 12', 'strictLength(1,12)'));
    if (employee < 0) results.add(CSMSetValidationResult(kEmployee, 'Employee pointer must be equal or greater than 0', 'pointerHandler()'));
    if (common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }

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
