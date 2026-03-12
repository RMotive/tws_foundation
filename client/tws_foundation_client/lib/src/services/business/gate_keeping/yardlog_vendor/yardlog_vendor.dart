
import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a business entity that stores the data for vendors and yard logs entities relations.
final class YardlogVendor extends EntityBase<YardlogVendor> {

  /// [YardlogVendor.yardlogId] property key for [DataMap].
  static const String kYardlogId = "yardlogId";

  /// [YardlogVendor.vendorId] property key for [DataMap].
  static const String kVendorId = "vendorId";

    /// [YardlogVendor.yardlog] property key for [DataMap].
  static const String kYardlog = "yardlog";

  /// Yardlog id related to this relation.
  BigInt yardlogId = BigInt.zero;

    /// Vendor id related to this relation.
  BigInt vendorId = BigInt.zero;
  
  /// [YardLog] related to this relation.
  YardLog yardlog = YardLog();
  
  /// Generates a new [YardlogVendor] instance from mandatory values.
  YardlogVendor();

  @override
  void decode(DataMap encode) {
    yardlogId = encode.get(kYardlogId);
    vendorId = encode.get(kVendorId);

    yardlog = encode.getEntity(() => YardLog(), kYardlog) ?? yardlog;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object>{
        kYardlogId: yardlogId,
        kVendorId: vendorId,
        kYardlog: yardlog.encode(),
      },
    );
  }
  
  @override
  List<EntityErrors<YardlogVendor>> evaluate(List<EntityErrors<YardlogVendor>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<YardlogVendor>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }

    if (yardlogId < BigInt.zero) {
      errors.add(
        EntityErrors<YardlogVendor>(
          this,
          PropertyInfo(kYardlogId, BigInt, yardlogId),
          'Pointer: $yardlogId, cannot be less than 0.',
          '$yardlogId < 0',
        ),
      );
    }

    if (vendorId < BigInt.zero) {
      errors.add(
        EntityErrors<YardlogVendor>(
          this,
          PropertyInfo(kVendorId, BigInt, vendorId),
          'Pointer: $vendorId, cannot be less than 0.',
          '$vendorId < 0',
        ),
      );
    }     

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(YardlogVendor ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);
    if (yardlogId != ref.yardlogId) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kYardlogId, int, yardlogId),
          yardlogId,
          ref.yardlogId,
          null,
        ),
      );
    }
    if (vendorId != ref.vendorId) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kVendorId, int, vendorId),
          vendorId,
          ref.vendorId,
          null,
        ),
      );
    }

    return aggregated;
  }
  

}
