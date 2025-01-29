import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';

///
final class ExportInventoryOut implements CSMEncodeInterface {
  ///
  final Uint8List content;

  ///
  final String name;

  ///
  final String type;

  ///
  const ExportInventoryOut(this.name, this.type, this.content);

  factory ExportInventoryOut.des(JObject json) {
    return ExportInventoryOut(
      json.get('name'),
      json.get('type'),
      Uint8List(2),
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'content': content,
      'name': name,
      'type': type,
    };
  }
}
