import 'package:csm_client_core/csm_client_core.dart';

/// {model} class for [ExportOutput].
///
/// Defines a data model object that represents a {View} operation {input} object.
final class ExportOutput implements IEncodable, IDecodable {

  /// [ExportOutput.content] property key.
  static const String kContent = 'content';
  
  /// [ExportOutput.name] property key.
  static const String kName = 'name';

  /// [ExportOutput.extension] property key.
  static const String kExtension = 'extension';

  /// base64 byte File content as bytes array.
  String content = '';

  /// File name.
  String name = '';

  /// File Extension.
  ExportOutExtensions extension = ExportOutExtensions.xlsx;

  /// Creates a new [ExportOutput] instance.
  ExportOutput();

  /// Creates a new [ExportOutput] instance based on relevant properties.
  ExportOutput.a(this.content, this.name, this.extension);

  @override
  DataMap encode() {
    return <String, Object?>{
      kContent: content,
      kName: name,
      kExtension: extension.index,
    };
  }
  
  @override
  void decode(DataMap encode) {
    content = encode.get(kContent);
    name = encode.get(kName);
    extension = ExportOutExtensions.values[encode.get(kExtension)];
  }

  
}

/// Supported export output file extensions.
enum ExportOutExtensions {
  /// Excel file format.
  xlsx,
}