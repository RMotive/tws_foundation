import 'dart:typed_data';

import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog extends EntityB {
  static const String kEntry = 'entry';
  static const String kSeal = 'seal';
  static const String kSealAlt = 'sealAlt';
  static const String kFromTo = 'fromTo';
  static const String kEvidence = 'evidence';
  static const String kDamage = 'damage';

  /// Wheter the record is an entry or exit entry.
  bool entry = false;

  /// Trailer seal information.
  String? seal = "";

  /// Trailer alternative seal information.
  String? sealAlt = "";

  /// Vehicule origin / destination information.
  String fromTo = "";

  /// Vehicule entry image evidence.
  Uint8List evidence = Uint8List.fromList(<int>[]);

  /// Vehicule damage image evidence.
  Uint8List? damage = Uint8List.fromList(<int>[]);

  /// Creates a new [YardLog] instance with default values.
  YardLog();

  @override
  JObject encode([JObject? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEntry: entry,
        kSeal: seal,
        kSealAlt: sealAlt,
        kFromTo: fromTo,
        kEvidence: evidence,
        kDamage: damage,
      },
    );
  }

  @override
  void decode(JObject encode) {
    entry = encode.get(kEntry);
    seal = encode.get(kSeal);
    sealAlt = encode.get(kSealAlt);
    fromTo = encode.get(kFromTo);
    evidence = encode.get(kEvidence);
    damage = encode.get(kDamage);

    super.decode(encode);
  }

  @override
  List<CSMEntityInvalidProperty> evaluate() {
    throw UnimplementedError();
  }
}
