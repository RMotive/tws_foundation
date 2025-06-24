import 'package:csm_client/csm_client.dart';


/// [VehiculeModel] default builder.
VehiculeModel vehiculemodelBuilder() => VehiculeModel();

final class VehiculeModel extends NamedEntityB<VehiculeModel> {

  /// [year] property key.
  static const String kYear = 'year';

  /// Model year.
  DateTime year = DateTime(0);

  /// Generates a new [VehiculeModel] instance from mandatory values.
  VehiculeModel();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        kYear: year.toUtc().toString(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    year = encode.get(kYear);
  }

  @override
  List<EntityInvalidation<VehiculeModel>> evaluate() {
    List<EntityInvalidation<VehiculeModel>> results = <EntityInvalidation<VehiculeModel>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<VehiculeModel>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    

    return results;
  }

}
