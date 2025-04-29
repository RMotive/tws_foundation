import 'dart:typed_data';

import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog extends EntityB<YardLog> {
  bool entry = false;

  String? seal = "";

  String? sealAlt = "";

  String fromTo = "";

  Uint8List evidence = Uint8List.fromList(<int>[]);

  Uint8List? damage = Uint8List.fromList(<int>[]);

  @override
  DataMap encode([DataMap? entityObject]) {
    super.encode();
    return <String, Object?>{};
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    entry = encode.get("entry");
    seal = encode.get("seal");
  }

  @override
  List<EntityInvalidation<YardLog>> evaluate() {
    return <EntityInvalidation<YardLog>>[];
  }
}
