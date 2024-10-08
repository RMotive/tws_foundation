import 'package:csm_foundation_services/csm_foundation_services.dart';

final class Solution implements CSMSetInterface {
  static const String kName = 'name';
  static const String kSign = 'sign';
  static const String kDescription = 'description';

  @override
  int id = 0;
  String name = '';
  String sign = '';
  String? description;

  Solution.a();
  Solution.b(this.name, this.sign, {this.id = 0, this.description});
  Solution(this.id, this.name, this.sign, this.description);
  factory Solution.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    String sign = json.get('sign');
    String? description = json.getDefault('description', null);

    return Solution(id, name, sign, description);
  }



  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kSign: sign,
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

  Solution clone({
    int? id,
    String? name,
    String? sign,
    String? description,
  }) {
    return Solution(id ?? this.id, name ?? this.name, sign ?? this.sign, description ?? this.description);
  }
}

final class SolutionDecoder implements CSMDecodeInterface<Solution> {
  const SolutionDecoder();

  @override
  Solution decode(JObject json) => Solution.des(json);
}
