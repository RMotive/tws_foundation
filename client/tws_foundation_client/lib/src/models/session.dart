import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a privileges model, that stores different session descriptive data, like auth token,
/// acceptable privileges, etc.
final class Session implements CSMEncodeInterface {
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

  /// Generates a new [Session] object.
  const Session(this.token, this.expiration, this.identity, this.wildcard, this.contact);

  /// Generates a new [Session] object based on [JObject] deserealization.
  factory Session.des(JObject json) {
    String token = json.get('token');
    DateTime expiration = json.get('expiration');
    String identity = json.get('identity');
    bool wildcard = json.getDefault('wildcard', false);
    Contact contact = Contact.des(json.getDefault('contact', <String, dynamic>{}));

    return Session(token, expiration, identity, wildcard, contact);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'token': token,
      'expiration': expiration.toString(),
      'identity': identity,
      'wildcard': wildcard,
      'contact': contact.encode(),
    };
  }
}
