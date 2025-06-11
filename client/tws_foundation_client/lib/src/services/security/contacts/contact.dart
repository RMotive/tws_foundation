import 'package:csm_client/csm_client.dart';

/// {entity} class.
///
/// Stores information about an {user} contact information.
final class Contact extends EntityB<Contact> {
  /// User name.
  ///
  /// Rules:
  ///   1. 101 > [name] > 0
  String name = '';

  /// User last name.
  ///
  /// Rules:
  ///   1. 101 > [lastName] > 0
  String lastName = '';

  /// User E-Mail address.
  ///
  /// Rules:
  ///   1. 101 > [eMail] > 0
  String eMail = '';

  /// User contact phone.
  ///
  /// Rules:
  ///   1. 15 > [phone] > 0
  String phone = '';

  /// Creates a new [Contact] instance.
  Contact();

  @override
  void decode(DataMap encode) {
    name = encode.get('name');
    lastName = encode.get('lastname');
    eMail = encode.get('email');
    phone = encode.get('phone');
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(<String, Object?>{
      'name': name,
      'lastname': lastName,
      'email': eMail,
      'phone': phone,
    });
  }

  @override
  List<EntityInvalidation<Contact>> evaluate() {
    List<EntityInvalidation<Contact>> invalidations = <EntityInvalidation<Contact>>[];

    if (name.length > 100 || name.isEmpty) {
      invalidations.add(
        EntityInvalidation<Contact>(
          this,
          PropertyInfo(
            'name',
            String,
            name,
          ),
          'Length rules violation',
          '101 > lastName > 0',
        ),
      );
    }

    if (lastName.length > 100 || lastName.isEmpty) {
      invalidations.add(
        EntityInvalidation<Contact>(
          this,
          PropertyInfo(
            'lastName',
            String,
            lastName,
          ),
          'Length rules violation',
          '101 > lastName > 0',
        ),
      );
    }

    if (eMail.length > 100 || eMail.isEmpty) {
      invalidations.add(
        EntityInvalidation<Contact>(
          this,
          PropertyInfo(
            'eMail',
            String,
            eMail,
          ),
          'Length rules violation',
          '101 > eMail > 0',
        ),
      );
    }

    if (phone.length > 100 || phone.isEmpty) {
      invalidations.add(
        EntityInvalidation<Contact>(
          this,
          PropertyInfo(
            'phone',
            String,
            phone,
          ),
          'Length rules violation',
          '15 > phone > 0',
        ),
      );
    }

    throw UnimplementedError();
  }
}
