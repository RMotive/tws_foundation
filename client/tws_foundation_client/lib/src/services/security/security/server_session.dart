import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contact.dart';

/// Defines a privileges model, that stores different session descriptive data, like auth token,
/// acceptable privileges, etc.
final class ServerSession implements EncodableI, DecodableI {
  /// Services auth token.
  String token;

  /// [token] timemark expiration
  DateTime expiration;

  /// Current user identity.
  String identity;

  /// Privileges wildcard, means can access everything.
  bool wildcard;

  /// User contact information.
  Contact contact;

  /// Generates a new [ServerSession] object.
  ServerSession(this.token, this.expiration, this.identity, this.wildcard, this.contact);

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
  
  @override
  void decode(DataMap encode) {
    token = encode.get('token');
    expiration = encode.get('expiration');
    identity = encode.get('identity');
    wildcard = encode.get('wildcard');

    if (encode['contact'] != null) {
      DataMap rawContact = encode.get('contact', <String, dynamic>{});
      contact = Contact();
      contact.decode(rawContact);
    }  
  }
}
