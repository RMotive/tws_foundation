import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/addresses/address.dart';

final class Carrier extends NamedEntityB<Carrier> {

  /// [approach] property key.
  static const String kApproach = "approach";

  /// [address] property key.
  static const String kAddress = "address";

  /// [usdot] property key.
  static const String kUsdot = "usdot";

  /// Foreign relation [Address] object.
  Address address = Address();

  /// Generates a new [Carrier] instance from mandatory values.
  Carrier();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kAddress: address.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    address.decode(encode.get(kAddress));
  }

  @override
  List<EntityInvalidation<Carrier>> evaluate() {
    List<EntityInvalidation<Carrier>> results = <EntityInvalidation<Carrier>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }

    return results;
  }

}
