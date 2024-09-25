import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';

/// Defines a credentials model that stores basic user firm to validate
/// services privileges.
final class Credentials implements CSMEncodeInterface {
  /// User account identity.
  final String identity;

  /// User account password sign.
  final Uint8List password;

  /// Solution context sign
  final String sign;

  /// Generates a new [Credentials] object.
  const Credentials(this.identity, this.password, this.sign);

  @override
  JObject encode() {
    return <String, dynamic>{
      'identity': identity,
      'password': base64Encode(password),
      'sign': sign,
    };
  }
}
