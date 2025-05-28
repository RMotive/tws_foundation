
import 'package:csm_client/csm_client.dart';
// TODO waypoint entity.
final class Waypoint extends EntityB<Waypoint> {

  /// [longitude] property key.
  static const String kLongitude = "longitude";
  
  /// Unique identificator reference.

  /// Generates a new [Status] instance from mandatory values.
  Waypoint();
  
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
  List<EntityInvalidation<Waypoint>> evaluate() {
    List<EntityInvalidation<Waypoint>> results = <EntityInvalidation<Waypoint>>[];
    
    return results;
  }

}
