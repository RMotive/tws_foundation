import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';

/// Common [Out] object for [Export] action services.
final class ExportOut implements CSMEncodeInterface {
  /// Propety key binder for [content].
  static const String _kContent = 'content';

  /// Property key binder for [name].
  static const String _kName = 'name';

  /// Property key binder for [extension].
  static const String _kExtension = 'extension';

  /// Export encoded file content.
  final Uint8List content;

  /// User friendly file name.
  final String name;

  /// File extension.
  final ExportOutExtensions extension;

  /// Creates a new [ExportOut] object instance storing the result from an [Export] service action.
  const ExportOut(this.name, this.extension, this.content);

  /// Creates a new [ExportOut] object instance storing the result from an [Export] service action, based on a [JObject].
  factory ExportOut.des(JObject json) {
    return ExportOut(
      json.get(_kName),
      ExportOutExtensions.values[json.get<int>(_kExtension)],
      base64Decode(json.get(_kContent)),
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'content': content,
      'name': name,
      'extension': extension.index,
    };
  }
}

/// Stores possible file extensions for [ExportOut] results.
enum ExportOutExtensions {
  /// Office Open XML Format.
  xlsx('xlsx');

  /// Stores the system friendly recognized extension code.
  final String value;

  /// Internally and statically creates a new [ExportOutExtensions] instance object storing enum configuration.
  const ExportOutExtensions(this.value);
}
