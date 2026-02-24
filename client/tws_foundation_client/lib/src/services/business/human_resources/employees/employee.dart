import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Employee] factory method.
Employee employeeFactory() => Employee();

/// {entity} class.
///
/// Represents a business physical human resource employee information.
final class Employee extends EntityBase<Employee> {
  /// [Employee.curp] property key.
  static const String kCurp = "curp";

  /// [Employee.rfc] property key.
  static const String kRfc = "rfc";

  /// [Employee.nss] property key.
  static const String kNss = "nss";

  /// [Employee.identification] property key.
  static const String kIdentification = "identification";

  /// [Employee.address] property key.
  static const String kAddress = "address";

  /// [Employee.approach] property key.
  static const String kApproach = "approach";

  /// [Employee.dates] property key.
  static const String kEmployeeDates = "dates";

  //! --> Properties

  /// 18 lenght CURP number.
  String? curp;

  /// 13 lenght RFC number.
  String? rfc;

  /// 11 lenght Mexican Social Asurance Number (NSS).
  String? nss;

  //! <-- Properties

  //! --> Relations

  /// [EmployeeDates] information.
  EmployeeDates dates = EmployeeDates();

  /// [Identification] information.
  Identification identification = Identification();

  /// [Status] information.
  Status status = Status();

  /// [Address] information.
  Address? address;

  /// [approach] information.
  Approach? approach;
  //! <-- Relations

  //! --> Getters

  String get fullName => identification.fullname;

  //! <-- Getters

  /// Generates a new [Employee] instance from mandatory values.
  Employee();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kCurp: curp,
        kRfc: rfc,
        kNss: nss,
        kIdentification: identification.encode(),
        kAddress: address?.encode(),
        kEmployeeDates: dates.encode(),
        kApproach: approach?.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    rfc = encode.get(kRfc, null);
    nss = encode.get(kNss, null);
    curp = encode.get(kCurp, null);

    dates = encode.getEntity(() => EmployeeDates(), kEmployeeDates) ?? dates;
    identification = encode.getEntity(() => Identification(), kIdentification) ?? identification;
    address = encode.getEntity(() => Address(), kAddress);
    approach = encode.getEntity(() => Approach(), kApproach);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status; 
  }

  @override
  List<EntityErrors<Employee>> evaluate(List<EntityErrors<Employee>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Employee>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (curp != null) {
      if (curp!.length != 18) {
        errors.add(
          EntityErrors<Employee>(
            this,
            PropertyInfo(kCurp, String, curp),
            "CURP number must be 18 length",
            "strictLength(18)",
          ),
        );
      }
    }

    if (rfc != null) {
      if (rfc!.length != 13) {
        errors.add(
          EntityErrors<Employee>(
            this,
            PropertyInfo(kRfc, String, rfc),
            "RFC number must be 13 length",
            "strictLength(13)",
          ),
        );
      }
    }

    if (nss != null) {
      if (nss!.length != 11) {
        errors.add(
          EntityErrors<Employee>(
            this,
            PropertyInfo(kNss, String, nss),
            "The NSS number must be 11 character length",
            "structLength(11)",
          ),
        );
      }
    }

    errors.validateDependency(this, dates);
    errors.validateDependency(this, identification);
    if (address != null) errors.validateDependency(this, address!);
    if (approach != null) errors.validateDependency(this, approach!);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> identificationDiff = identification.compare(ref.identification);
    List<ObjectDifference> datesDiff = dates.compare(ref.dates);
    List<ObjectDifference> statusDiff = status.compare(ref.status);
    
    if (curp != ref.curp) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCurp, String, curp),
          curp,
          ref.curp,
          null,
        ),
      );
    }

    if (rfc != ref.rfc) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kRfc, String, rfc),
          rfc,
          ref.rfc,
          null,
        ),
      );
    }

    if (nss != ref.nss) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kNss, String, nss),
          nss,
          ref.nss,
          null,
        ),
      );
    }

    if(statusDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
      );
    }

    if(identificationDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kIdentification, Identification, identification),
          identification,
          ref.identification,
          identificationDiff,
        ),
      );
    }

    if(datesDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEmployeeDates, EmployeeDates, dates),
          dates,
          ref.dates,
          datesDiff,
        ),
      );
    }

    if(ref.address != null){
      List<ObjectDifference> addressDiff = address?.compare(ref.address!) ?? <ObjectDifference>[];
      if(addressDiff.isNotEmpty){
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kAddress, Address, address),
            address,
            ref.address,
            addressDiff,
          ),
        );
      }
    }

    if(ref.approach != null){
      List<ObjectDifference> approachDiff = approach?.compare(ref.approach!) ?? <ObjectDifference>[];
      if(approachDiff.isNotEmpty){
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kApproach, Approach, approach),
            approach,
            ref.approach,
            approachDiff,
          ),
        );
      }
    }

    return aggregated;
  }
}
