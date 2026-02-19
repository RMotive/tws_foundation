import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {model} class for [AuthenticationInput].
///
/// Defines a data model class that represents an {input} object for [SecurityServiceI.authenticate] operation that handles
/// [FoundationServer] authentication processes.
final class AuthenticationInput implements IEncodable {
  /// Solution context sign
  String sign = '';

  /// User account identity.
  String identity = '';

  /// User account password sign.
  Uint8List password = Uint8List(0);

  /// Generates a new [AuthenticationInput] object.
  AuthenticationInput();

  ///
  AuthenticationInput.a(this.sign, this.identity, this.password);

  @override
  DataMap encode() {
    return <String, dynamic>{
      'sign': sign,
      'identity': identity,
      'password': base64Encode(password),
    };
  }
}
