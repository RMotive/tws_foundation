import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class VehiculeModel extends NamedEntityB<VehiculeModel> {

  /// [year] property key.
  static const String kYear = 'year';

  /// Model year.
  DateTime year = DateTime(0);

  /// Entity [Status] information.
  Status?  status;

  /// Generates a new [VehiculeModel] instance from mandatory values.
  VehiculeModel();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kYear: year.toUtc().toString(),
          EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    year = encode.get(kYear);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, DataMap()));
    }
  }

  @override
  List<EntityInvalidation<VehiculeModel>> evaluate() {
    List<EntityInvalidation<VehiculeModel>> results = <EntityInvalidation<VehiculeModel>>[];

   if (id < 0) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.trim().length > 100) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.name, String, name), 'Name must be empty or have a maximun 100 characters', 'strictLength()'));
    if (description != null && description!.trim().length > 200) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.description, String, description), 'Description must be empty or have a maximun 200 characters', 'strictLength()'));
    return results;
  }

}
