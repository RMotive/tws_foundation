import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Usdot] defines a business entity that stores information for a USDOT that operates in vehicule.
final class Usdot extends EntityBase<Usdot>{

  /// [Usdot.mc] property key.
  static const String kMC = "mc";

  /// [Usdot.scac] property key.
  static const String kSCAC = "scac";

  // TODO to define.
  String mc = "";

  // TODO to define.
  String scac = "";

  /// [Status] information.
  Status status = Status();

  /// Creates a new [Usdot] instance.
  Usdot();

  Usdot? sanitize({
    String? mc,
    String? scac,
  }) {
    this.mc = mc.sanitizeOrFallback(this.mc) ?? '';
    this.scac = scac.sanitizeOrFallback(this.scac) ?? '';

    if (this.mc.isEmpty && this.scac.isEmpty) {
      return null;
    }

    return this;
  }

  @override
  void decode(DataMap encode) {
    mc = encode.get(kMC) ?? mc;
    scac = encode.get(kSCAC) ?? scac;
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status; 
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kMC: mc,
        kSCAC: scac,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );

  }

  @override
  List<EntityErrors<Usdot>> evaluate(List<EntityErrors<Usdot>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Usdot>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (mc.length != 7 || mc.trim().isEmpty) {
      errors.add(
        EntityErrors<Usdot>(
          this,
          PropertyInfo(kMC, String, mc),
          "Length: ${mc.length}, must be exactly 7 characters",
          "length == 7",
        ),
      );
    }

    if (scac.length != 4 || scac.trim().isEmpty) {
      errors.add(
        EntityErrors<Usdot>(
          this,
          PropertyInfo(kSCAC, String, scac),
          "Length: ${scac.length}, must be exactly 4 characters",
          "length == 4",
        ),
      );
    }

    errors.validateDependency(this, status);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }

  


}