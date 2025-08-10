import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/extensions.dart';

final class EmployeeDates extends EntityB<EmployeeDates> {
 
  /// [imms] property key.
  static const String kImss = "imss";

  /// [hire] property key.
  static const String kHire = "hire";

  /// [termination] property key.
  static const String kTermination = "termination";

  /// [cnap] property key.
  static const String kCnap = "cnap";

  /// IMSS registration Date.
  DateTime? imss;

  /// Employeer hiring date.
  DateTime? hire;

  /// termination date for date.
  DateTime? termination;

  /// Expiration date for (Certificado de No Antecedentes Penales / Certificate of No Criminal Records) document.
  DateTime? cnap;

  /// Generates a new [EmployeeDates] instance from mandatory values.
  EmployeeDates();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kImss: imss?.dateOnlyIso,
          kHire: hire?.dateOnlyIso,
          kTermination: termination?.dateOnlyIso,
          kCnap: cnap?.dateOnlyIso,
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    imss = encode.get(kImss);
    hire = encode.get(kHire);
    termination = encode.get(kTermination);
    cnap = encode.get(kCnap);
  }

  @override
  List<EntityInvalidation<EmployeeDates>> evaluate() {
    List<EntityInvalidation<EmployeeDates>> results = <EntityInvalidation<EmployeeDates>>[];
    return results;
  }

}
