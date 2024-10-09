import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Employee implements CSMSetInterface {
  static const String kIdentification = "identification";
  static const String kAddress = "address";
  static const String kApproach = "approach";
  static const String kCurp = "curp";
  static const String kAntecedentesNoPenalesExp = "antecedentesNoPenalesExp";
  static const String kRfc = "rfc";
  static const String kNss = "nss";
  static const String kImssRegistrationDate = "imssRegistrationDate";
  static const String kHiringdate = "hiringDate";
  static const String kTerminationDate = "terminationDate";
  static const String kIdentificationNavigation = 'IdentificationNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int identification = 0;
  int? address;
  int? approach;
  String? curp;
  DateTime? antecedentesNoPenalesExp;
  String? rfc;
  String? nss;
  DateTime? imssRegistrationDate;
  DateTime? hiringDate;
  DateTime? terminationDate;
  Identification? identificationNavigation;
  Status? statusNavigation;

  Employee(this.id, this.status, this.identification, this.address, this.approach, this.curp, this.antecedentesNoPenalesExp, this.rfc, this.nss, this.imssRegistrationDate, this.hiringDate, this.terminationDate, this.identificationNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

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
        
    return Employee(id, status, identification, address, approach, curp, antecedentesNoPenalesExp, rfc, nss, imssRegistrationDate, hiringDate, terminationDate, identificationNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String? a = antecedentesNoPenalesExp?.toString().substring(0,10);
    String? b = imssRegistrationDate?.toString().substring(0,10);
    String? c = hiringDate?.toString().substring(0,10);
    String? d =  terminationDate?.toString().substring(0,10);

    return <String, dynamic>{
      'id': id,
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
      if(nss!.length != 11) results.add(CSMSetValidationResult(kNss, "SCAC number must be 4 length", "structLength(11)"));
    }
    if(identificationNavigation != null) results = <CSMSetValidationResult>[...results, ...identificationNavigation!.evaluate()];   

    return results;
  }
  Employee.def();
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
    Status? statusNavigation
  }){
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
      statusNavigation ?? this.statusNavigation
    );
  }
}
