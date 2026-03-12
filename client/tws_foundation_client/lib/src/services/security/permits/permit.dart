import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/security/actions/action.dart';
import 'package:tws_foundation_client/src/services/security/features/feature.dart';
import 'package:tws_foundation_client/src/services/security/solutions/solution.dart';

/// {implementation} class for an [IEntity].
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
  List<EntityErrors<Permit>> evaluate(List<EntityErrors<Permit>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Permit>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Permit>(
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
          EntityErrors<Permit>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (reference.length != 8) {
        errors.add(
          EntityErrors<Permit>(
            this,
            PropertyInfo(CorePropertiesConsts.reference, String, reference),
            'lentgh: ${reference.length}, must be exactly 8 characters',
            'length == 8',
          ),
        );
      }

    errors.validateDependency(this, solution);
    errors.validateDependency(this, feature);
    errors.validateDependency(this, action);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Permit ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> actionDiff = action.compare(ref.action);
    List<ObjectDifference> solutionDiff = solution.compare(ref.solution);
    List<ObjectDifference> featureDiff = feature.compare(ref.feature);

    if(name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.name, String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

     if(description != ref.description) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.description, String, description),
          description,
          ref.description,
          null,
        ),
      );
    }

     if(reference != ref.reference) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          reference,
          ref.reference,
          null,
        ),
      );
    }


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

    if (solutionDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kSolution, Solution, solution),
          solution,
          ref.solution,
          solutionDiff,
        ),
      );
    }

    if (featureDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kFeature, Feature, feature),
          feature,
          ref.feature,
          featureDiff,
        ),
      );
    }

    if (actionDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAction, Action, action),
          action,
          ref.action,
          actionDiff,
        ),
      );
    }

    return aggregated;
  }
}
