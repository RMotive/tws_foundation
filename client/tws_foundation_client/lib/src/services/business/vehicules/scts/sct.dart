import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityB] ... TODO: Define purpose.
final class SCT extends EntityB<SCT> {
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
        FoundationCommonPropertyKeys.kStatus: status,
      },
    );
  }

  @override
  List<EntityInvalidation<SCT>> evaluate() {
    final List<EntityInvalidation<SCT>> invs = <EntityInvalidation<SCT>>[];

    if (type.length != 6) {
      invs.add(
        EntityInvalidation<SCT>(
          this,
          PropertyInfo(kType, String, type),
          'Wrong legth ${type.length}, must be 6.',
          'length == 6',
        ),
      );
    }

    if (number.length != 25) {
      invs.add(
        EntityInvalidation<SCT>(
          this,
          PropertyInfo(kNumber, String, number),
          'Wrong legth ${number.length}, must be 25.',
          'length == 25',
        ),
      );
    }

    if (configuration.isEmpty || configuration.length > 10) {
      invs.add(
        EntityInvalidation<SCT>(
          this,
          PropertyInfo(kConfiguration, String, configuration),
          'Wring length ${configuration.length}, must be between 1 and 10.',
          '11 > length > 0',
        ),
      );
    }

    return invs;
  }
}
