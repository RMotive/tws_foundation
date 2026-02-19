import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityBase] ... TODO: Define purpose.
final class SCT extends EntityBase<SCT> {
  /// [SCT.type] property key for [DataMap].
  static const String kType = "type";

  /// [SCT.number] property key for [DataMap].
  static const String kNumber = "number";

  /// [SCT.configuration] property key for [DataMap].
  static const String kConfiguration = "configuration";

  /// [trucks] property key.
  static const String kTrucks = "trucks";

  //! --> Properties

  /// Type identifier
  ///
  /// Rules >
  ///   1. length == 6
  String type = "";

  /// Number identificator.
  ///
  /// Rules >
  ///   1. length == 25
  String number = "";

  /// Document configuration.
  ///
  /// Rules >
  ///   1. 11 > length > 5
  String configuration = "";

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [SCT] instance.
  SCT();

  /// Validate nulleable inputs to avoid [SCT] entities with empty values.
  SCT? sanitize({
    String? type,
    String? number,
    String? configuration,
  }){
    this.type = type.sanitizeOrFallback(this.type) ?? '';
    this.number = number.sanitizeOrFallback(this.number) ?? '';
    this.configuration = configuration.sanitizeOrFallback(this.configuration) ?? '';

    if (this.type.isEmpty && this.number.isEmpty && this.configuration.isEmpty) {
      return null;
    }
    return this;
  }

  @override
  void decode(DataMap encode) {
    type = encode.get(kType);
    number = encode.get(kNumber);
    configuration = encode.get(kConfiguration);

    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object>{
        kType: type,
        kNumber: number,
        kConfiguration: configuration,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityErrors<SCT>> evaluate(List<EntityErrors<SCT>> errors) {
    errors = super.evaluate(errors);

    if (type.length != 6) {
      errors.add(
        EntityErrors<SCT>(
          this,
          PropertyInfo(kType, String, type),
          'Wrong legth ${type.length}, must be 6.',
          'length == 6',
        ),
      );
    }

    if (number.length != 25) {
      errors.add(
        EntityErrors<SCT>(
          this,
          PropertyInfo(kNumber, String, number),
          'Wrong legth ${number.length}, must be 25.',
          'length == 25',
        ),
      );
    }

    if (configuration.isEmpty || configuration.length > 10) {
      errors.add(
        EntityErrors<SCT>(
          this,
          PropertyInfo(kConfiguration, String, configuration),
          'Wring length ${configuration.length}, must be between 1 and 10.',
          '11 > length > 0',
        ),
      );
    }

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
