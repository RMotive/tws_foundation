import 'dart:typed_data';

import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog implements CSMSetInterface {
  @override
  int id = 0;

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  bool entry = false;

  String? seal = "";

  String? sealAlt = "";

  String fromTo = "";

  Uint8List evidence = Uint8List.fromList(<int>[]);

  Uint8List? damage = Uint8List.fromList(<int>[]);

  @override
  JObject encode() {
    return <String, Object?>{};
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    return <CSMSetValidationResult>[];
  }
}
