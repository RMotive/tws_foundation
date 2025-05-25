import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Maintenance extends EntityB<Maintenance> {

  /// [anual] property key.
  static const String kAnual = "anual";

  /// [trimestral] property key.
  static const String kTrimestral = "trimestral";

  /// Anual maintenance date.
  DateTime anual = DateTime(0);

  /// Trimestral maintenance date.
  DateTime trimestral = DateTime(0);
  
  /// Foregin relation [Status] object.
  Status status = Status();

  /// Generates a new [Maintenance] instance from mandatory values.
  Maintenance();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        EntitiesCommonProperties.kStatus: status.encode(),
        kAnual: anual.toUtc().toIso8601String(),
        kTrimestral: trimestral.toUtc().toIso8601String(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    status.decode(encode.get(EntitiesCommonProperties.kStatus));
    anual = encode.get(kAnual);
    trimestral = encode.get(kTrimestral);
  }

  @override
  List<EntityInvalidation<Maintenance>> evaluate() {
    List<EntityInvalidation<Maintenance>> results = <EntityInvalidation<Maintenance>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Maintenance>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    results.validateDependency(this, status);
    return results;
  }

}
