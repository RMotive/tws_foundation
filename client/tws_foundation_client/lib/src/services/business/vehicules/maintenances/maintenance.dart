import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityBase] that stores information about maintenance scheduling information.
final class Maintenance extends EntityBase<Maintenance> {
  /// [Maintenance.anual] property key for [DataMap].
  static const String kAnual = "anual";

  /// [Maintenance.trimestral] property key for [DataMap].
  static const String kTrimestral = "trimestral";

  //! --> Properties

  /// Next anual maintenance schedule.
  DateTime anual = DateTime(0);

  /// Next trimestral maintenance schedule.
  DateTime trimestral = DateTime(0);

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [Maintenance] instance.
  Maintenance();

  /// Validate nulleable inputs to avoid [Maintenance] entities with empty values.
  Maintenance? sanitize({
    DateTime? anual,
    DateTime? trimestral,
  }) {
    this.anual = anual ?? this.anual;
    this.trimestral = trimestral ?? this.trimestral;

    if(this.anual == DateTime(0) && this.trimestral == DateTime(0)) {
      return null;
    } 

    return this;
  }

  @override
  void decode(DataMap encode) {
    anual = encode.get(kAnual);
    trimestral = encode.get(kTrimestral);

    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object>{
        kAnual: anual.dateOnlyIso,
        kTrimestral: anual.dateOnlyIso,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityErrors<Maintenance>> evaluate(List<EntityErrors<Maintenance>> errors) {
    errors = super.evaluate(errors);
    errors.validateDependency(this, status);
    return errors;

  }
  
  @override
  List<ObjectDifference> compare(Maintenance ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if (anual != ref.anual) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAnual, DateTime, anual),
          anual,
          ref.anual,
          null,
        ),
      );
    }
    if (trimestral != ref.trimestral) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kTrimestral, DateTime, trimestral),
          trimestral,
          ref.trimestral,
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

    return aggregated;
  }
}
