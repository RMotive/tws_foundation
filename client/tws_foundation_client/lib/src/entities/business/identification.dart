import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Identification extends EntityB<Identification> {
  
  /// [lastname] property key.
  static const String kLastname = 'lastname';

  /// [birthday] property key.
  static const String kbirthday = 'birthday';

  /// Personal names.
  String name = "";

  /// Father last name.
  String lastname = "";

  /// Father last name.
  DateTime? birthday;

  /// [Status] object.
  Status? status;

  /// Generates a new [Identification] instance from mandatory values.
  Identification();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          EntityKeys.name: name,
          kLastname: lastname,
          kbirthday: birthday?.toUtc().toString(),
          EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    name = encode.get(EntityKeys.name);
    lastname = encode.get(kLastname);
    birthday = encode.get(kbirthday, null);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }  
  }

  @override
  List<EntityInvalidation<Identification>> evaluate() {
    List<EntityInvalidation<Identification>> results = <EntityInvalidation<Identification>>[];

    if (name.trim().isEmpty || name.length > 32) results.add(EntityInvalidation<Identification>(this, PropertyInfo(EntityKeys.name, String, name), "El nombre no debe de estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if (lastname.trim().isEmpty || lastname.length > 32) results.add(EntityInvalidation<Identification>(this, PropertyInfo(kLastname, String, lastname), "El apellido no debe estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    return results;
  }

}
