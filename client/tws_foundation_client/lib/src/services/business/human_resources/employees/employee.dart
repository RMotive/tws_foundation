import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Employee] factory method.
Employee employeeFactory() => Employee();

/// {entity} class.
///
/// Represents a business physical human resource employee information.
final class Employee extends EntityB<Employee> {
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
  List<EntityInvalidation<Employee>> evaluate() {
    List<EntityInvalidation<Employee>> invalidations = <EntityInvalidation<Employee>>[];

    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Employee>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (curp != null) {
      if (curp!.length != 18) {
        invalidations.add(
          EntityInvalidation<Employee>(
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
        invalidations.add(
          EntityInvalidation<Employee>(
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
        invalidations.add(
          EntityInvalidation<Employee>(
            this,
            PropertyInfo(kNss, String, nss),
            "The NSS number must be 11 character length",
            "structLength(11)",
          ),
        );
      }
    }

    invalidations.validateDependency(this, dates);
    invalidations.validateDependency(this, identification);
    if (address != null) invalidations.validateDependency(this, address!);
    if (approach != null) invalidations.validateDependency(this, approach!);

    return invalidations;
  }
}
