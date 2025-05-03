import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {model} class for [ServerSession].
///
/// Defines a data model implementation that represents a [FoundationServer] {session} computated and managed by the server.
final class ServerSession implements DecodableI, EncodableI {
  /// Privileges wildcard, means can access everything.
  bool wildcard = false;

  /// Services auth token.
  String token = '';

  /// Current user identity.
  String identity = '';

  /// [token] timemark expiration
  DateTime expiration = DateTime(0);

  /// Generates a new [ServerSession] instance.
  ServerSession();

  @override
  void decode(DataMap encode) {
    token = encode.get('token');
    identity = encode.get('identity');
    expiration = encode.get('expiration');
    wildcard = encode.get('wildcard', false);
  }

  @override
  DataMap encode() {
    return <String, Object?>{
      'wildcard': wildcard,
      'token': token,
      'identity': identity,
      'expiration': expiration.toIso8601String(),
    };
  }
}
