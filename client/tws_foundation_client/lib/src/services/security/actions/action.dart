import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/permits/permit.dart';

/// {implementation} class for an [EntityI].
///
/// [Entity] that represents the information for certain actions/operations to be performed to the Solutions.
final class Action extends NamedEntityB<Action> { 

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
  List<EntityInvalidation<Action>> evaluate() {
    List<EntityInvalidation<Action>> results = <EntityInvalidation<Action>>[];
    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Action>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Action>(
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
          EntityInvalidation<Action>(
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
