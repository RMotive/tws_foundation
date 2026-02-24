import 'package:csm_client_core/csm_client_core.dart';

/// {entity} class.
///
/// Stores information about an {user} contact information.
final class Contact extends EntityBase<Contact> {
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
  List<EntityErrors<Contact>> evaluate(List<EntityErrors<Contact>> errors) {
    errors = super.evaluate(errors);


    if (name.length > 100 || name.trim().isEmpty) {
      errors.add(
        EntityErrors<Contact>(
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

    if (lastName.length > 100 || lastName.trim().isEmpty) {
      errors.add(
        EntityErrors<Contact>(
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

    if (eMail.length > 100 || eMail.trim().isEmpty) {
      errors.add(
        EntityErrors<Contact>(
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

    if (phone.length > 100 || phone.trim().isEmpty) {
      errors.add(
        EntityErrors<Contact>(
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

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Contact ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    if (name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('name', String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

    if (lastName != ref.lastName) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('lastName', String, lastName),
          lastName,
          ref.lastName,
          null,
        ),
      );
    }

    if (eMail != ref.eMail) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('eMail', String, eMail),
          eMail,
          ref.eMail,
          null,
        ),
      );
    }

    if (phone != ref.phone) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('phone', String, phone),
          phone,
          ref.phone,
          null,
        ),
      );
    }

    return aggregated;
  }
}
