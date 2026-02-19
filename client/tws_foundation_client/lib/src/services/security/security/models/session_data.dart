import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {model} class for [SessionData].
///
/// Defines a data model implementation that represents a [FoundationServer] {session} computated and managed by the server.
final class SessionData implements IDecodable, IEncodable {
  /// Privileges wildcard, means can access everything.
  bool wildcard = false;

  /// Services auth token.
  String token = '';

  /// [token] timemark expiration
  DateTime expiration = DateTime(0);

  /// User contact information.
  Contact contact = Contact();

  /// Generates a new [SessionData] instance.
  SessionData();

  @override
  void decode(DataMap encode) {
    token = encode.get('token');
    expiration = encode.get('expiration');
    wildcard = encode.get('wildcard', false);

    DataMap contactDataMap = encode.get('contact');

    contact = Contact();
    contact.decode(contactDataMap);
  }

  @override
  DataMap encode() {
    return <String, Object?>{
      'token': token,
      'wildcard': wildcard,
      'contact': contact.encode(),
      'expiration': expiration.toIso8601String(),
    };
  }
}
