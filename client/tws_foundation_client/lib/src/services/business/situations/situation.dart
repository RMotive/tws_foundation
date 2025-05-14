
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Situation extends NamedEntityB<Situation> {

  /// [Status] navigation set.
  Status? status;

  /// Generates a new [Situation] instance from mandatory values.
  Situation();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }  
  }

  @override
  List<EntityInvalidation<Situation>> evaluate() {
    List<EntityInvalidation<Situation>> results = <EntityInvalidation<Situation>>[];
    return results;
  }

}
