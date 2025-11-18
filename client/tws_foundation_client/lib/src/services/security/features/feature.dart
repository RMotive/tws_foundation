import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/permits/permit.dart';

/// {implementation} class for an [EntityI].
///
/// [Entity] that represents a complex Feature storing different actions, this to determine Feature Scoped permits.
/// only for authorization purposes.
final class Feature extends NamedEntityB<Feature> { 

  /// [Feature.permits] property key.
  static const String kPermits = 'Permits';

  /// [Feature.enabled] property key.
  static const String kEnabled = 'enabled';

  /// Enabled status.
  bool enabled = false;

  /// [Permit]s information.
  List<Permit> permits = <Permit>[];
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    enabled = encode.get(kEnabled);
    List<DataMap> permitsMaps = encode.getList(kPermits);
    if (permitsMaps.isNotEmpty) {
      permits = permitsMaps.map<Permit>(
        (DataMap e) {
          Permit permit = Permit();
          permit.decode(e);
          return permit;
        },
      ).toList();
    }
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEnabled: enabled,
        kPermits: permits
            .map(
              (Permit e) => e.encode(),
            )
            .toList(),
      },
    );
  }

  @override
  List<EntityInvalidation<Feature>> evaluate() {
    List<EntityInvalidation<Feature>> results = <EntityInvalidation<Feature>>[];
    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Feature>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Feature>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        results.add(
          EntityInvalidation<Feature>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (permits.isNotEmpty) {
      for (Permit plate in permits) {
        results.validateDependency(this, plate);
      }
    }
    return results;
  }

}
