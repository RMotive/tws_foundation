import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class USDOT extends EntityB<USDOT> {
  /// [mc] property key.
  static const String kMc = "mc";
  /// [scac] property key.
  static const String kScac = "scac";
  ///
  String mc = "";
  ///
  String scac = "";
  ///
  Status? status;

  /// Generates a new [USDOT] instance from mandatory values.
  USDOT();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kMc: mc,
        kScac: scac,
        EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    mc = encode.get(kMc);
    scac = encode.get(kScac);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }

  }

  @override
  List<EntityInvalidation<USDOT>> evaluate() {
    List<EntityInvalidation<USDOT>> results = <EntityInvalidation<USDOT>>[];

    if(mc.length != 7) results.add(EntityInvalidation<USDOT>(this, PropertyInfo(kMc, String, mc), "MC number must be 7 length", "strictLength(7)"));
    if(scac.length != 4) results.add(EntityInvalidation<USDOT>(this, PropertyInfo(kScac, String, scac),"SCAC number must be 4 length", "structLength(4)"));
    return results;
  }

}
