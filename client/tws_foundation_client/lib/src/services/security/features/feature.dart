import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/permits/permit.dart';

/// {implementation} class for an [IEntity].
///
/// [Entity] that represents a complex Feature storing different actions, this to determine Feature Scoped permits.
/// only for authorization purposes.
final class Feature extends NamedEntityBase<Feature> { 

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
  List<EntityErrors<Feature>> evaluate(List<EntityErrors<Feature>> errors) {
    errors = super.evaluate(errors);
    
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Feature>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Feature>(
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
          EntityErrors<Feature>(
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
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
