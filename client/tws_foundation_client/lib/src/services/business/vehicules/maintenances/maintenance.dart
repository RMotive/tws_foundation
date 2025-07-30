import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityB] that stores information about maintenance scheduling information.
final class Maintenance extends EntityB<Maintenance> {
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
        kAnual: anual.dateOnly,
        kTrimestral: anual.dateOnly,
        FoundationCommonPropertyKeys.kStatus: status,
      },
    );
  }

  @override
  List<EntityInvalidation<Maintenance>> evaluate() {
    return <EntityInvalidation<Maintenance>>[];
  }
}
