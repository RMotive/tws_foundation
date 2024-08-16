import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_foundation_services/csm_foundation_services.dart';

/// Defines a credentials model that stores basic user firm to validate
/// services privileges.
final class Credentials implements CSMEncodeInterface {
  /// User account identity.
  final String identity;

  /// User account password sign.
  final Uint8List password;

  /// Generates a new [Credentials] object.
  const Credentials(this.identity, this.password);

  @override
  JObject encode() {
    return <String, dynamic>{
      'identity': identity,
      'password': base64Encode(password),
    };
  }
}
