
import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a business entity that stores any binary content for files or images representations.
final class Resource extends NamedEntityB<Resource> {
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
    file = encode.get(kFile);
    extension = encode.get(kExtension);
    yardlog = encode.getEntity(() => YardLog(), kYardLog);
    super.decode(encode);
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kFile: file,
        kExtension: extension,
        kYardLog: yardlog?.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Resource>> evaluate() {
    List<EntityInvalidation<Resource>> results = <EntityInvalidation<Resource>>[];
    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Resource>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Resource>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        results.add(
          EntityInvalidation<Resource>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (file.isEmpty) {
      results.add(
        EntityInvalidation<Resource>(
          this,
          PropertyInfo(kFile, Uint8List, file),
          "$kFile content cannot be empty.",
          "Length > 0",
        ),
      );
    }
    
    if(extension.trim().isEmpty || extension.length > 6) {
      results.add(
        EntityInvalidation<Resource>(
          this,
          PropertyInfo(kExtension, String, extension),
          "Lenght: ${extension.length}, must be between 1 and 6 characters.",
          "7 > length > 0",
        ),
      );
    }

    return results;
  }
}
