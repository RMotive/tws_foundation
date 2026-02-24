import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/permits/permit.dart';

/// {implementation} class for an [IEntity].
///
/// [EntityBase] that represents the information for certain actions/operations to be performed to the Solutions.
final class Action extends NamedEntityBase<Action> { 

  /// [Action.permits] property key.
  static const String kPermits = 'Permits';

  /// [Action.enabled] property key.
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
  List<EntityErrors<Action>> evaluate(List<EntityErrors<Action>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Action>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Action>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Action>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (permits.isNotEmpty) {
      for (Permit plate in permits) {
        errors.validateDependency(this, plate);
      }
    }
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Action ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    if (enabled != ref.enabled) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEnabled, bool, enabled),
          enabled,
          ref.enabled,
          null,
        ),
      );
    }

    for(Permit permit in permits){
      Permit? refPermit = ref.permits.firstWhere((Permit e) => e.id == permit.id, orElse: () => Permit());
      List<ObjectDifference> permitDiff = permit.compare(refPermit);

      if (permitDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kPermits, Permit, permit),
            permit,
            refPermit,
            permitDiff,
          ),
        );
      }
    }

    return aggregated;
  }
}
