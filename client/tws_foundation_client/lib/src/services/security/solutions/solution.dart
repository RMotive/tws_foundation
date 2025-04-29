import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/constants.dart';

final class Solution implements NamedEntityB<Solution> {
  static const String kName = 'name';
  static const String kSign = 'sign';
  static const String kDescription = 'description';
  
  /// Interface identifier.
  @override
  int id = 0;
  
  /// Record database pointer.
  @override
  String discriminator = "";

  /// Timestamp property.
  @override
  DateTime timestamp = DateTime.now();
  
  @override
  String name = "";

  @override
  String? description;

  String sign = '';

  /// Generates a new [Solution] instance with default values.
  Solution.a();

  /// Generates a new [Solution] instance from mandatory values.
  Solution.b(
    this.name,
    this.sign, {
    this.id = 0,
    this.discriminator = "",
    this.description,
  });

  /// Generates a new [Solution] instance.
  Solution(
    this.id,
    this.discriminator,
    this.timestamp,
    this.name,
    this.sign,
    this.description, 
  );
  

  /// Geneates a new [Solution] instance based on a [JObject] data.
  factory Solution.des(DataMap json) {
    int id = json.get(EntitiesCommonProperties.kId);
    String discriminator = json.get(EntitiesCommonProperties.kDiscriminator);
    DateTime timestamp = json.get(EntitiesCommonProperties.kTimestamp);
    String name = json.get('name');
    String sign = json.get('sign');
    String? description = json.get('description', null);

    return Solution(
      id,
      discriminator,
      timestamp,
      name,
      sign,
      description,
    );
  }

  Solution clone({
    int? id,
    String? discriminator,
    DateTime? timestamp,
    String? name,
    String? sign,
    String? description,
  }) {
    return Solution(
      id ?? this.id,
      discriminator ?? this.discriminator,
      timestamp ?? this.timestamp,
      name ?? this.name,
      sign ?? this.sign,
      description ?? this.description,
    );
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return <String, dynamic>{
      EntitiesCommonProperties.kId: id,
      EntitiesCommonProperties.kDiscriminator: discriminator,
      EntitiesCommonProperties.kTimestamp: timestamp.toIso8601String(),
      kName: name,
      kSign: sign,
      kDescription: description,
    };
  }

  @override
  void decode(DataMap encode) {

  }

  @override
  List<EntityInvalidation<Solution>> evaluate() {
    List<EntityInvalidation<Solution>> results = <EntityInvalidation<Solution>>[];

    // if (name.isEmpty) results.add(EntityInvalidation<Solution>(this, get, 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
