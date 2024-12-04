import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
/// Employee information set object. 
/// This set stores the relevant data and navigatiors for solutions employees.
final class Employee implements CSMSetInterface {

  /// [Identification] property key.
  static const String kIdentification = "identification";

  /// [Address] property key.
  static const String kAddress = "address";
  
  /// [Approach] property key.
  static const String kApproach = "approach";

  /// [curp] property key.
  static const String kCurp = "curp";

  /// [antecedentesNoPenalesExp] property key.
  static const String kAntecedentesNoPenalesExp = "antecedentesNoPenalesExp";

  /// [rfc] property key.
  static const String kRfc = "rfc";

  /// [nss] property key.
  static const String kNss = "nss";

  /// [imssRegistrationDate] property key.
  static const String kImssRegistrationDate = "imssRegistrationDate";

  /// [hiringDate] property key.
  static const String kHiringdate = "hiringDate";

  /// [terminationDate] property key.
  static const String kTerminationDate = "terminationDate";

  /// [identificationNavigation] property key.
  static const String kIdentificationNavigation = 'IdentificationNavigation';

  /// [addressNavigation] property key.
  static const String kAddressNavigation = 'AddressNavigation';

  /// [approachNavigation] property key.
  static const String kApproachNavigation = 'ApproachNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;
  
  /// Foreign relation [Status] pointer.
  int status = 1;
  
  /// Foreign relation [Identification] pointer.
  int identification = 0;

  /// Foreign relation [Address] pointer.
  int? address;

  /// Foreign relation [Approach] pointer.
  int? approach;

  /// 18 lenght CURP number.
  String? curp;

  /// Expiration date for "antecedentes no penales" document.
  DateTime? antecedentesNoPenalesExp;

  /// 12 lenght RFC number.
  String? rfc;

  /// 11 lenght Mexican Social Asurance Number (NSS). 
  String? nss;
  
  /// IMSS registrationDate.
  DateTime? imssRegistrationDate;

  /// Employeer hiring date.
  DateTime? hiringDate;

  /// termination date for date.
  DateTime? terminationDate;

  /// [Identification] set navigation.
  Identification? identificationNavigation;

  /// [Status] set navigation.
  Status? statusNavigation;

  /// [Address] set navigation.
  Address? addressNavigation;

  /// [Approach]/Contact set navigation.
  Approach? approachNavigation;

  /// Creates an [Employee] object with default properties.
  Employee.a();

  /// Creates an [Employee] object with required properties.
  Employee(
    this.id,
    this.status,
    this.identification,
    this.address,
    this.approach,
    this.curp,
    this.antecedentesNoPenalesExp,
    this.rfc,
    this.nss,
    this.imssRegistrationDate,
    this.hiringDate,
    this.terminationDate,
    this.identificationNavigation,
    this.statusNavigation,
    this.addressNavigation,
    this.approachNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Method that creates an [Employee] object based on a serialized json object as parameter.
  factory Employee.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int identification = json.get(kIdentification);
    int? address = json.getDefault(kAddress, null);
    int? approach = json.getDefault(kApproach, null);
    String? curp = json.getDefault(kCurp, null);

    String? antecedentesExp = json.getDefault(kAntecedentesNoPenalesExp, null);
    DateTime? antecedentesNoPenalesExp = antecedentesExp != null? DateTime.parse(antecedentesExp) : null;

    String? rfc = json.getDefault(kRfc, null);
    String? nss = json.getDefault(kNss, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    
    String? imssReg = json.getDefault(kImssRegistrationDate, null);
    DateTime? imssRegistrationDate = imssReg != null? DateTime.parse(imssReg) : null;

    String? hiringD = json.getDefault(kHiringdate, null);
    DateTime? hiringDate = hiringD != null? DateTime.parse(hiringD) : null;

    String? terminationD =  json.getDefault(kTerminationDate, null);
    DateTime? terminationDate = terminationD != null? DateTime.parse(terminationD) : null;

    Identification? identificationNavigation;
    if (json[kIdentificationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kIdentificationNavigation, <String, dynamic>{});
      identificationNavigation = Identification.des(rawNavigation);
    }

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Address? addressNavigation;
    if (json[kAddressNavigation] != null) {
      JObject rawNavigation = json.getDefault(kAddressNavigation, <String, dynamic>{});
      addressNavigation = Address.des(rawNavigation);
    }

    Approach? approachNavigation;
    if (json[kApproachNavigation] != null) {
      JObject rawNavigation = json.getDefault(kApproachNavigation, <String, dynamic>{});
      approachNavigation = Approach.des(rawNavigation);
    }

    return Employee(
      id,
      status,
      identification,
      address,
      approach,
      curp,
      antecedentesNoPenalesExp,
      rfc,
      nss,
      imssRegistrationDate,
      hiringDate,
      terminationDate,
      identificationNavigation,
      statusNavigation,
      addressNavigation,
      approachNavigation,
      timestamp: timestamp,
    );
  }

  @override
  JObject encode() {
    String? a = antecedentesNoPenalesExp?.toString().substring(0,10);
    String? b = imssRegistrationDate?.toString().substring(0,10);
    String? c = hiringDate?.toString().substring(0,10);
    String? d =  terminationDate?.toString().substring(0,10);

    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kIdentification: identification,
      kAddress: address,
      kApproach: approach,
      kCurp: curp,
      kAntecedentesNoPenalesExp: a,
      kRfc: rfc,
      kNss: nss,
      kImssRegistrationDate: b,
      kHiringdate: c,
      kTerminationDate: d,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kIdentificationNavigation: identificationNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
      kAddressNavigation: addressNavigation?.encode(),
      kApproachNavigation: approachNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identification <= 0 && identificationNavigation == null) results.add(CSMSetValidationResult(kIdentification, 'Identification pointer must be equal or greater than 0, or set a navigation', 'pointerHandler()'));
   
    if(address != null){
      if(address! < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    }

    if(approach != null){
      if(approach! < 0) results.add(CSMSetValidationResult(kApproach, 'Approach pointer must be equal or greater than 0', 'pointerHandler()'));
    }
    
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    if(curp != null){
      if(curp!.length != 18) results.add(CSMSetValidationResult(kCurp, "CURP number must be 18 length", "strictLength(18)"));
    }

    if(rfc != null){
      if(rfc!.length != 12) results.add(CSMSetValidationResult(kRfc, "CURP number must be 18 length", "strictLength(12)"));
    }

    if(nss != null){
      if(nss!.length != 11) results.add(CSMSetValidationResult(kNss, "The NSS number must be 11 character length", "structLength(11)"));
    }

    if(identificationNavigation != null) results = <CSMSetValidationResult>[...results, ...identificationNavigation!.evaluate()];   
    if(addressNavigation != null) results = <CSMSetValidationResult>[...results, ...addressNavigation!.evaluate()];   
    if(approachNavigation != null) results = <CSMSetValidationResult>[...results, ...approachNavigation!.evaluate()];   

    return results;
  }
  
  /// Create an [Employee] copy object, overriding the given parameters. 
  Employee clone({
    int? id,
    int? status,
    int? identification,
    int? address,
    int? approach,
    String? curp,
    DateTime? antecedentesNoPenalesExp,
    String? rfc,
    String? nss,
    DateTime? imssRegistrationDate,
    DateTime? hiringDate,
    DateTime? terminationDate,
    Identification? identificationNavigation,
    Status? statusNavigation,
    Address? addressNavigation,
    Approach? approachNavigation,
  }){

    if(identification == 0){
      this.identificationNavigation = null;
      identificationNavigation = null;
    }

    if(address == 0){
      this.addressNavigation = null;
      this.address = null;
      addressNavigation = null;
      address = null;
    }

    if(approach == 0){
      this.approachNavigation = null;
      this.approach = null;
      approachNavigation = null;
      approach = null;
    }

    if(curp != null && curp.trim().isEmpty){
      this.curp = null;
      curp = null;
    }

    if(rfc != null && rfc.trim().isEmpty){
      this.rfc = null;
      rfc = null;
    }

    if(nss != null && nss.trim().isEmpty){
      this.nss = null;
      nss = null;
    }

    if(antecedentesNoPenalesExp == DateTime(0)){
      this.antecedentesNoPenalesExp = null;
      antecedentesNoPenalesExp = null;
    }

    if(imssRegistrationDate == DateTime(0)){
      this.imssRegistrationDate = null;
      imssRegistrationDate = null;
    }

    if(hiringDate == DateTime(0)){
      this.hiringDate = null;
      hiringDate = null;
    }

    if(terminationDate == DateTime(0)){
      this.terminationDate = null;
      terminationDate = null;
    }

    return Employee(
      id ?? this.id, 
      status ?? this.status, 
      identification ?? this.identification, 
      address ?? this.address, 
      approach ?? this.approach, 
      curp ?? this.curp,
      antecedentesNoPenalesExp ?? this.antecedentesNoPenalesExp, 
      rfc ?? this.rfc, nss ?? this.nss, 
      imssRegistrationDate ?? this.imssRegistrationDate, 
      hiringDate ?? this.hiringDate,
      terminationDate ?? this.terminationDate, 
      identificationNavigation ?? this.identificationNavigation, 
      statusNavigation ?? this.statusNavigation,
      addressNavigation ?? this.addressNavigation,
      approachNavigation ?? this.approachNavigation,
    );
  }
}
