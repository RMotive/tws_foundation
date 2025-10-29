import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/actions/action.dart';
import 'package:tws_foundation_client/src/services/security/features/feature.dart';
import 'package:tws_foundation_client/src/services/security/solutions/solution.dart';

/// {implementation} class for an [EntityI].
///
/// [Entity] that stores and handles specific Feature / Solution / Action authorization for Accounts.
final class Permit extends NamedReferencedEntityB<Permit> {
  
  /// [Permit.enabled] property key.
  static const String kEnabled = 'enabled';

  /// [Permit.solution] property key.
  static const String kSolution = 'solution';

  /// [Permit.action] property key.
  static const String kAction = 'action';

  /// [Permit.feature] property key.
  static const String kFeature = 'feature';

  /// Enabled status.
  bool enabled = false;

  /// [Solution] information.
  Solution solution = Solution();

  /// [Feature] information.
  Feature feature = Feature();

  /// [Action] information.
  Action action = Action();

  /// Creates a new [Permit] instance.
  Permit();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    enabled = encode.get(kEnabled);
    solution = encode.getEntity(() => Solution(), kSolution) ?? Solution();
    feature = encode.getEntity(() => Feature(), kFeature) ?? Feature();
    action = encode.getEntity(() => Action(), kAction) ?? Action();
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEnabled: enabled,
        kSolution: solution.encode(),
        kFeature: feature.encode(),
        kAction: action.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Permit>> evaluate() {
    List<EntityInvalidation<Permit>> invalidations = <EntityInvalidation<Permit>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Permit>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      invalidations.add(
        EntityInvalidation<Permit>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }

    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        invalidations.add(
          EntityInvalidation<Permit>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    invalidations.validateDependency(this, solution);
    invalidations.validateDependency(this, feature);
    invalidations.validateDependency(this, action);

    return invalidations;
  }
}
