import 'package:csm_client/csm_client.dart';

final class Status extends NamedEntityB<Status> {

  /// Generates a new [Status] instance from mandatory values.
  Status();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode();
  }
  
  @override
  // ignore: unnecessary_overrides
  void decode(DataMap encode) {
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Status>> evaluate() {
    List<EntityInvalidation<Status>> results = <EntityInvalidation<Status>>[];
    if(name.length >25) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 25 length", "structLength(25)"));
    if(description != null && description!.length > 150) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 150 max length", "structLength(0,150)"));    
    return results;
  }

}
