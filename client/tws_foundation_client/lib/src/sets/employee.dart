import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Employee implements CSMSetInterface {
  static const String kStatus = "status";
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
  static const String kIdentificationNavigation = 'identificationNavigation';
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 0;
  int identification = 0;
  int address = 0;
  int approach = 0;
  String curp = "";
  DateTime antecedentesNoPenalesExp = DateTime.now();
  String rfc = "";
  String nss = "";
  DateTime imssRegistrationDate = DateTime.now();
  DateTime? hiringDate;
  DateTime? terminationDate;
  Identification? identificationNavigation;
  Status? statusNavigation;

  Employee(this.id, this.status, this.identification, this.address, this.approach, this.curp, this.antecedentesNoPenalesExp, this.rfc, this.nss, this.imssRegistrationDate, this.hiringDate, this.terminationDate, this.identificationNavigation, this.statusNavigation);
  factory Employee.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int identification = json.get('identification');
    int address = json.get('address');
    int approach = json.get('approach');
    String curp = json.get('curp');
    DateTime antecedentesNoPenalesExp = json.get('antecedentesNoPenalesExp');
    String rfc = json.get('rfc');
    String nss = json.get('nss');
    DateTime imssRegistrationDate = json.get('imssRegistrationDate');
    DateTime hiringDate = json.get('hiringDate');
    DateTime terminationDate = json.get('terminationDate');

    Identification? identificationNavigation;
    if (json['IdentificationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('IdentificationNavigation', <String, dynamic>{});
      identificationNavigation = deserealize<Identification>(rawNavigation, decode: IdentificationDecoder());
    }

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return Employee(id, status, identification, address, approach, curp, antecedentesNoPenalesExp, rfc, nss, imssRegistrationDate, hiringDate, terminationDate, identificationNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    String a = antecedentesNoPenalesExp.toString().substring(0,10);
    String b = imssRegistrationDate.toString().substring(0,10);
    String? c = hiringDate?.toString().substring(0,10);
    String? d =  terminationDate?.toString().substring(0,10);

    return <String, dynamic>{
      'id': id,
      kStatus: status,
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
      kIdentificationNavigation: identificationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identification < 0) results.add(CSMSetValidationResult(kIdentification, 'Identification pointer must be equal or greater than 0', 'pointerHandler()'));
    if(address < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    if(approach < 0) results.add(CSMSetValidationResult(kApproach, 'Approach pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    if(curp.length != 18) results.add(CSMSetValidationResult(kCurp, "CURP number must be 18 length", "strictLength(18)"));
    if(rfc.length != 12) results.add(CSMSetValidationResult(kRfc, "CURP number must be 18 length", "strictLength(12)"));
    if(nss.length != 11) results.add(CSMSetValidationResult(kNss, "SCAC number must be 4 length", "structLength(11)"));

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
    return Employee(id ?? this.id, status ?? this.status, identification ?? this.identification, address ?? this.address, approach ?? this.approach, curp ?? this.curp,
    antecedentesNoPenalesExp ?? this.antecedentesNoPenalesExp, rfc ?? this.rfc, nss ?? this.nss, imssRegistrationDate ?? this.imssRegistrationDate, hiringDate ?? this.hiringDate,
    terminationDate ?? this.terminationDate, identificationNavigation ?? this.identificationNavigation, statusNavigation ?? this.statusNavigation
    );
  }
}

final class EmployeeDecoder implements CSMDecodeInterface<Employee> {
  const EmployeeDecoder();

  @override
  Employee decode(JObject json) {
    return Employee.des(json);
  }
}
