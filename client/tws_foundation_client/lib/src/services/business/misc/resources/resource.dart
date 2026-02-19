
import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a business entity that stores any binary content for files or images representations.
final class Resource extends NamedEntityBase<Resource> {
  /// [Resource.file] property key.
  static const String kFile = 'file';

  /// [Resource.extension] property key.
  static const String kExtension = 'extension';

  /// [Resource.yardlog] property key.
  static const String kYardLog = 'yardlog';
  
  //! --> Properties

  /// File content as bytes array.
  Uint8List file = Uint8List.fromList(<int>[]);

  ///  File extension format. e. g., "jpg", "pdf", etc.
  /// 
  /// Rules >
  ///   1. 6 > length > 0
  String extension = "";

  //! <-- Properties

  //! --> Relations

  /// Associated [YardLog] entry for which this resource is attached.
  YardLog? yardlog;

  //! <-- Relations
  /// Generates a new [Resource] instance from mandatory values.
  Resource();
  
  @override
  void decode(DataMap encode) {
    file = Uint8List.fromList(utf8.encode(encode.get(kFile)));
    extension = encode.get(kExtension);
    yardlog = encode.getEntity(() => YardLog(), kYardLog);
    super.decode(encode);
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kFile: base64Encode(file),
        kExtension: extension,
        kYardLog: yardlog?.encode(),
      },
    );
  }

  @override
 List<EntityErrors<Resource>> evaluate(List<EntityErrors<Resource>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Resource>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Resource>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Resource>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (file.isEmpty) {
      errors.add(
        EntityErrors<Resource>(
          this,
          PropertyInfo(kFile, Uint8List, file),
          "$kFile content cannot be empty.",
          "Length > 0",
        ),
      );
    }
    
    if(extension.trim().isEmpty || extension.length > 6) {
      errors.add(
        EntityErrors<Resource>(
          this,
          PropertyInfo(kExtension, String, extension),
          "Lenght: ${extension.length}, must be between 1 and 6 characters.",
          "7 > length > 0",
        ),
      );
    }

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
