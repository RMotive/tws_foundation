import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents an external driver, wich are commonly third party businesses with alliances.
final class Approach extends EntityB<Approach> {
  /// [Approach.email] property key for [DataMap].
  static const String kEmail = "email";

  /// [Approach.enterprise] property key for [DataMap].
  static const String kEnterprise = "enterprise";

  /// [Approach.personal] property key for [DataMap].
  static const String kPersonal = "personal";

  /// [Approach.alternative] property key for [DataMap].
  static const String kAlternative = "alternative";

  //! --> Properties
  
  /// Email address for the contact/approach.
  String? email;

  /// enterprise phone number.
  String? enterprise;

  /// personal phone number.
  String? personal;

  /// Alternative contact method.
  String? alternative;


  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [Approach] instance.
  Approach();

  @override
  void decode(DataMap encode) {
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    email = encode.get(kEmail, null);
    enterprise = encode.get(kEnterprise, null);
    personal = encode.get(kPersonal, null);
    alternative = encode.get(kAlternative, null);
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Approach>> evaluate() {
    List<EntityInvalidation<Approach>> invalidations = <EntityInvalidation<Approach>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (email != null && email!.length > 64) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(kEmail, String, email),
          'Email length cannot exceed 64 characters',
          'StrictLength()',
        ),
      );
    }

    if (enterprise != null && enterprise!.length > 13) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(kEnterprise, String, enterprise),
          'Enterprise phone length cannot exceed 13 characters',
          'StrictLength()',
        ),
      );
    }
    if (personal != null && personal!.length > 13) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(kPersonal, String, personal),
          'Personal phone length cannot exceed 13 characters',
          'StrictLength()',
        ),
      );
    }
    if (alternative != null && alternative!.length > 30) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(kAlternative, String, alternative),
          'Alternative contact length cannot exceed 30 characters',
          'StrictLength()',
        ),
      );
    }
    
    invalidations.validateDependency(this, status);

    return invalidations;
  }
}
