import 'package:csm_foundation_services/csm_foundation_services.dart';
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
  int status = 0;
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

  Driver(this.id, this.status, this.employee, this.common, this.driverType, this.licenseExpiration, this.drugalcRegistrationDate, this.pullnoticeRegistrationDate, this.twic,
  this.twicExpiration, this.visa, this.visaExpiration, this.fast, this.fastExpiration, this.anam, this.anamExpiration, this.driverCommonNavigation, this.employeeNavigation, this.statusNavigation);
  factory Driver.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int employee = json.get('employee');
    int common = json.get('common');
    String driverType = json.get('driverType');
    DateTime licenseExpiration = json.get('licenseExpiration');
    DateTime drugalcRegistrationDate = json.get('drugalcRegistrationDate');
    DateTime pullnoticeRegistrationDate = json.get('pullnoticeRegistrationDate');
    String? twic = json.getDefault('twic', null);
    DateTime twicExpiration = json.get('twicExpiration');
    String? visa = json.getDefault('visa', null);
    DateTime visaExpiration = json.get('visaExpiration');
    String? fast = json.getDefault('fast', null);
    DateTime fastExpiration = json.get('fastExpiration');
    String? anam = json.getDefault('anam', null);
    DateTime anamExpiration = json.get('anamExpiration');
    
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    DriverCommon? driverCommonNavigation;
    if (json['DriverCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverCommonNavigation', <String, dynamic>{});
      driverCommonNavigation = deserealize<DriverCommon>(rawNavigation, decode: DriverCommonDecoder());
    }

    Employee? employeeNavigation;
    if (json['EmployeeNavigation'] != null) {
      JObject rawNavigation = json.getDefault('EmployeeNavigation', <String, dynamic>{});
      employeeNavigation = deserealize<Employee>(rawNavigation, decode: EmployeeDecoder());
    }
        
    return Driver(id, status, employee, common, driverType, licenseExpiration, drugalcRegistrationDate, pullnoticeRegistrationDate, twic, twicExpiration, visa, visaExpiration,
    fast, fastExpiration, anam, anamExpiration, driverCommonNavigation, employeeNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    String a = licenseExpiration.toString().substring(0,10);
    String b = driverCommonNavigation.toString().substring(0,10);
    String c = pullnoticeRegistrationDate.toString().substring(0,10);
    String? d = twicExpiration?.toString().substring(0,10);
    String? e = visaExpiration?.toString().substring(0,10);
    String? f = fastExpiration?.toString().substring(0,10);
    String? g = anamExpiration?.toString().substring(0,10);

    return <String, dynamic>{
      'id': id,
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
    if(driverType.isEmpty || driverType.length > 12) results.add(CSMSetValidationResult(kDriverType, 'Driver Type length must be between 1 and 12', 'strictLength(1,12)'));
    if(employee < 0) results.add(CSMSetValidationResult(kEmployee, 'Employee pointer must be equal or greater than 0', 'pointerHandler()'));
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Driver.def();
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
    Status? statusNavigation
  }){
    return Driver(id ?? this.id, status ?? this.status, employee ?? this.employee, common ?? this.common, driverType ?? this.driverType, licenseExpiration ?? this.licenseExpiration,
    drugalcRegistrationDate ?? this.drugalcRegistrationDate, pullnoticeRegistrationDate ?? this.pullnoticeRegistrationDate, twic ?? this.twic, twicExpiration ?? this.twicExpiration,
    visa ?? this.visa, visaExpiration ?? this.visaExpiration, fast ?? this.fast, fastExpiration ?? this.fastExpiration, anam ?? this.anam, anamExpiration ?? this.anamExpiration,
    driverCommonNavigation ?? this.driverCommonNavigation, employeeNavigation ?? this.employeeNavigation, statusNavigation ?? this.statusNavigation
    );
  }
}

final class DriverDecoder implements CSMDecodeInterface<Driver> {
  const DriverDecoder();

  @override
  Driver decode(JObject json) {
    return Driver.des(json);
  }
}
