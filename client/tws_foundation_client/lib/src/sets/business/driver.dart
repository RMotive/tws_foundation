import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Driver implements CSMSetInterface {
  static const String kEmployee = "employee";
  static const String kCommon = "common";
  static const String kTimestamp = "timestamp";
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

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 


  @override
  int id = 0;
  int status = 1;
  int employee = 0;
  int common = 0;
  String? driverType;
  DateTime? licenseExpiration;
  DateTime? drugalcRegistrationDate;
  DateTime? pullnoticeRegistrationDate;
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
  this.twicExpiration, this.visa, this.visaExpiration, this.fast, this.fastExpiration, this.anam, this.anamExpiration, this.driverCommonNavigation, this.employeeNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  Driver.a();

  factory Driver.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int employee = json.get(kEmployee);
    int common = json.get(kCommon);
    String? driverType = json.getDefault(kDriverType, null);
    DateTime timestamp = json.get(SCK.kTimestamp);

    String? licenExp = json.getDefault(kLicenseExpiration, null);
    DateTime? licenseExpiration = licenExp != null? DateTime.parse(licenExp) : null;
    

    String? drugal = json.getDefault(kDrugalcRegistrationDate, null);
    DateTime? drugalcRegistrationDate = drugal != null? DateTime.parse(drugal) : null;

    String? pullnotice = json.getDefault(kPullnoticeRegistrationDate, null);
    DateTime? pullnoticeRegistrationDate = pullnotice != null? DateTime.parse(pullnotice) : null;
    
    String? twic = json.getDefault(kTwic, null);

    String? twicEx = json.getDefault(kTwicExpiration, null);
    DateTime? twicExpiration = twicEx != null? DateTime.parse(twicEx) : null;

    String? visa = json.getDefault(kVisa, null);

    String? visaExp = json.getDefault(kVisaExpiration, null);
    DateTime? visaExpiration = visaExp != null? DateTime.parse(visaExp) : null;

    String? fast = json.getDefault(kFast, null);

    String? fastExp = json.getDefault(kFastExpiration, null);
    DateTime? fastExpiration = fastExp != null? DateTime.parse(fastExp) : null;

    String? anam = json.getDefault(kAnam, null);

    String? anamExp = json.getDefault(kAnamExpiration, null);
    DateTime? anamExpiration = anamExp != null? DateTime.parse(anamExp) : null;
    
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
        
    return Driver(id, status, employee, common, driverType, licenseExpiration, drugalcRegistrationDate, pullnoticeRegistrationDate, twic, twicExpiration, visa, visaExpiration,
    fast, fastExpiration, anam, anamExpiration, driverCommonNavigation, employeeNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String? a = licenseExpiration?.toString().substring(0,10);
    String? b = drugalcRegistrationDate?.toString().substring(0,10);
    String? c = pullnoticeRegistrationDate?.toString().substring(0,10);
    String? d = twicExpiration?.toString().substring(0,10);
    String? e = visaExpiration?.toString().substring(0,10);
    String? f = fastExpiration?.toString().substring(0,10);
    String? g = anamExpiration?.toString().substring(0,10);

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
      kTimestamp: timestamp.toIso8601String(),
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kEmployeeNavigation: employeeNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(driverType != null){
      if(driverType!.trim().isEmpty || driverType!.length > 12) results.add(CSMSetValidationResult(kDriverType, 'Driver Type length must be between 1 and 12', 'strictLength(1,12)'));
    }
    if(employee <= 0 && employeeNavigation == null) results.add(CSMSetValidationResult(kEmployee, 'Debe ingresar los datos del empleado. Employee pointer must be equal or greater than 0', 'pointerHandler()'));
    if(common <= 0 && driverCommonNavigation == null) results.add(CSMSetValidationResult(kCommon, 'Debe ingresar los datos comunes del conductor. Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(driverCommonNavigation != null) results = <CSMSetValidationResult>[...results, ...driverCommonNavigation!.evaluate()];   
    if(employeeNavigation != null) results = <CSMSetValidationResult>[...results, ...employeeNavigation!.evaluate()];   

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
    Status? statusNavigation
  }){
    return Driver(
      id ?? this.id, 
      status ?? this.status, 
      employee ?? this.employee, 
      common ?? this.common, 
      driverType ?? this.driverType, 
      licenseExpiration ?? this.licenseExpiration,
      drugalcRegistrationDate ?? this.drugalcRegistrationDate, 
      pullnoticeRegistrationDate ?? this.pullnoticeRegistrationDate, 
      twic ?? this.twic, twicExpiration ?? this.twicExpiration,
      visa ?? this.visa, visaExpiration ?? this.visaExpiration, 
      fast ?? this.fast, fastExpiration ?? this.fastExpiration, 
      anam ?? this.anam, anamExpiration ?? this.anamExpiration,
      driverCommonNavigation ?? this.driverCommonNavigation, 
      employeeNavigation ?? this.employeeNavigation, 
      statusNavigation ?? this.statusNavigation
    );
  }
}