import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/extensions.dart';

final class EmployeeDates extends EntityBase<EmployeeDates> {
 
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
  List<EntityErrors<EmployeeDates>> evaluate(List<EntityErrors<EmployeeDates>> errors) {
    errors = super.evaluate(errors);
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(EmployeeDates ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);
    
    if (imss != ref.imss) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kImss, DateTime, imss),
          imss,
          ref.imss,
          null,
        ),
      );
    }

    if (hire != ref.hire) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kHire, DateTime, hire),
          hire,
          ref.hire,
          null,
        ),
      );
    }

    if (termination != ref.termination) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kTermination, DateTime, termination),
          termination,
          ref.termination,
          null,
        ),
      );
    }

    if (cnap != ref.cnap) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCnap, DateTime, cnap),
          cnap,
          ref.cnap,
          null,
        ),
      );
    }

    return aggregated;
  }

}
