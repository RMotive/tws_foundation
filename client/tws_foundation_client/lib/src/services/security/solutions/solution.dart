import 'package:csm_client/csm_client.dart';

final class Solution implements CSMSetInterface {
  static const String kName = 'name';
  static const String kSign = 'sign';
  static const String kDescription = 'description';
  static const String kTimestamp = "timestamp";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  String name = '';
  String sign = '';
  String? description;

  /// Generates a new [Solution] instance with default values.
  Solution.a({
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Generates a new [Solution] instance from mandatory values.
  Solution.b(
    this.name,
    this.sign, {
    this.id = 0,
    this.description,
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Generates a new [Solution] instance.
  Solution(
    this.id,
    this.name,
    this.sign,
    this.description, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Geneates a new [Solution] instance based on a [JObject] data.
  factory Solution.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    String sign = json.get('sign');
    DateTime timestamp = json.get('timestamp');
    String? description = json.getDefault('description', null);

    return Solution(id, name, sign, description, timestamp: timestamp);
  }

  Solution clone({
    int? id,
    String? name,
    String? sign,
    String? description,
  }) {
    return Solution(
      id ?? this.id,
      name ?? this.name,
      sign ?? this.sign,
      description ?? this.description,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kSign: sign,
      kTimestamp: timestamp.toIso8601String(),
      kDescription: description,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];

    if (name.isEmpty) results.add(CSMSetValidationResult(kName, 'Solution name can\'t be empty', 'notEmpty'));
    if (sign.length != 5) results.add(CSMSetValidationResult(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }
}
