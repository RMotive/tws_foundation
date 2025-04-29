import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a privileges model, that stores different session descriptive data, like auth token,
/// acceptable privileges, etc.
final class ServerSession implements EncodableI {
  /// Services auth token.
  final String token;

  /// [token] timemark expiration
  final DateTime expiration;

  /// Current user identity.
  final String identity;

  /// Privileges wildcard, means can access everything.
  final bool wildcard;

  /// User contact information.
  final Contact contact;

  /// Generates a new [ServerSession] object.
  const ServerSession(this.token, this.expiration, this.identity, this.wildcard, this.contact);

  /// Generates a new [ServerSession] object based on [JObject] deserealization.
  factory ServerSession.des(DataMap json) {
    String token = json.get('token');
    DateTime expiration = json.get('expiration');
    String identity = json.get('identity');
    bool wildcard = json.get('wildcard', false);
    Contact contact = Contact.des(json.get('contact', <String, dynamic>{}));

    return ServerSession(token, expiration, identity, wildcard, contact);
  }

  @override
  DataMap encode() {
    return <String, dynamic>{
      'token': token,
      'expiration': expiration.toString(),
      'identity': identity,
      'wildcard': wildcard,
      'contact': contact.encode(),
    };
  }
}
