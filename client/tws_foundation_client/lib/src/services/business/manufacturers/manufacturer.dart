import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Manufacturer extends NamedEntityB<Manufacturer> {

  /// Entity [Status] information.
  Status?  status;

  /// Generates a new [Manufacturer] instance from mandatory values.
  Manufacturer();
  
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
          encode.get(EntitiesCommonProperties.kStatus, DataMap()));
    }  
  }

  @override
  List<EntityInvalidation<Manufacturer>> evaluate() {
    List<EntityInvalidation<Manufacturer>> results = <EntityInvalidation<Manufacturer>>[];

    if (id < 0) results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.id, int, id), 'Solution pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.trim().length > 100) results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.name, String, name), 'Name must be empty or have a maximun 100 characters', 'strictLength()'));
    if (description != null && description!.trim().length > 200) results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.description, String, description), 'Description must be empty or have a maximun 200 characters', 'strictLength()'));

    
    return results;
  }

}
