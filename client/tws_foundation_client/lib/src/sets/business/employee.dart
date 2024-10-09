import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
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
  int status = 1;
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

  Employee(this.id, this.status, this.identification, this.address, this.approach, this.curp, this.antecedentesNoPenalesExp, this.rfc, this.nss, this.imssRegistrationDate, this.hiringDate,
      this.terminationDate, this.identificationNavigation, this.statusNavigation);

  Employee.a();

  factory Employee.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int identification = json.get(kIdentification);
    int address = json.get(kAddress);
    int approach = json.get(kApproach);
    String curp = json.get(kCurp);
    DateTime antecedentesNoPenalesExp = json.get(kAntecedentesNoPenalesExp);
    String rfc = json.get(kRfc);
    String nss = json.get(kNss);
    DateTime imssRegistrationDate = json.get(kImssRegistrationDate);
    DateTime hiringDate = json.get(kHiringdate);
    DateTime terminationDate = json.get(kTerminationDate);

    Identification? identificationNavigation;
    if (json[kIdentificationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kIdentificationNavigation, <String, dynamic>{});
      identificationNavigation = Identification.des(rawNavigation);
    }

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return Employee(
        id, status, identification, address, approach, curp, antecedentesNoPenalesExp, rfc, nss, imssRegistrationDate, hiringDate, terminationDate, identificationNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    String a = antecedentesNoPenalesExp.toString().substring(0, 10);
    String b = imssRegistrationDate.toString().substring(0, 10);
    String? c = hiringDate?.toString().substring(0, 10);
    String? d = terminationDate?.toString().substring(0, 10);

    return <String, dynamic>{
      SCK.kId: id,
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

  Employee clone(
      {int? id,
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
      Status? statusNavigation}) {
    return Employee(
        id ?? this.id,
        status ?? this.status,
        identification ?? this.identification,
        address ?? this.address,
        approach ?? this.approach,
        curp ?? this.curp,
        antecedentesNoPenalesExp ?? this.antecedentesNoPenalesExp,
        rfc ?? this.rfc,
        nss ?? this.nss,
        imssRegistrationDate ?? this.imssRegistrationDate,
        hiringDate ?? this.hiringDate,
        terminationDate ?? this.terminationDate,
        identificationNavigation ?? this.identificationNavigation,
        statusNavigation ?? this.statusNavigation);
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (identification < 0) results.add(CSMSetValidationResult(kIdentification, 'Identification pointer must be equal or greater than 0', 'pointerHandler()'));
    if (address < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    if (approach < 0) results.add(CSMSetValidationResult(kApproach, 'Approach pointer must be equal or greater than 0', 'pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    if (curp.length != 18) results.add(CSMSetValidationResult(kCurp, "CURP number must be 18 length", "strictLength(18)"));
    if (rfc.length != 12) results.add(CSMSetValidationResult(kRfc, "CURP number must be 18 length", "strictLength(12)"));
    if (nss.length != 11) results.add(CSMSetValidationResult(kNss, "SCAC number must be 4 length", "structLength(11)"));

    return results;
  }
}
