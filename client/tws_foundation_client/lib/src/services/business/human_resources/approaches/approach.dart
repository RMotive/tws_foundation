import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// This class represents the contact information in the human resources domain.
final class Approach extends EntityBase<Approach> {
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
  String email = "";

  /// Enterprise phone number.
  String? enterprise;

  /// Personal phone number.
  String? personal;

  /// Alternative contact method.
  String? alternative;

  //! <-- Properties

  //! --> Relations

  /// [Status] Data.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [Approach] instance.
  Approach();

   /// Validate nulleable inputs to avoid [Approach] entities with empty values.
  Approach? sanitize({
    String? email,
    String? enterprise,
    String? personal,
    String? alternative,
  }) {
    this.email = email.sanitizeOrFallback(this.email) ?? "";
    this.enterprise = enterprise.sanitizeOrFallback(this.enterprise);
    this.personal = personal.sanitizeOrFallback(this.personal);
    this.alternative = alternative.sanitizeOrFallback(this.alternative);

    if (this.email.trim().isEmpty &&
        this.enterprise == null &&
        this.personal == null &&
        this.alternative == null) {
      return null;
    }

    return this;
  }
  

  @override
  void decode(DataMap encode) {
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    email = encode.get(kEmail);
    enterprise = encode.get(kEnterprise);
    personal = encode.get(kPersonal);
    alternative = encode.get(kAlternative);
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEmail: email,
        kEnterprise: enterprise,
        kPersonal: personal,
        kAlternative: alternative,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityErrors<Approach>> evaluate(List<EntityErrors<Approach>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Approach>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (email.trim().isEmpty || email.length > 64) {
      errors.add(
        EntityErrors<Approach>(
          this,
          PropertyInfo(kEmail, String, email),
          'Length: ${email.length}, Email length cannot exceed 64 characters or be empty',
          '65 > length > 0',
        ),
      );
    }

    if (enterprise != null) {
      if (enterprise!.length > 13) {
        errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kEnterprise, String, enterprise),
            'Enterprise phone length: ${enterprise?.length} cannot exceed 13 characters',
            '14 > length || length == null',
          ),
        );
      }

      if(enterprise!.trim().isEmpty){
        errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kEnterprise, String, enterprise),
            'Enterprise phone length: ${enterprise?.length}, cannot be empty if provided',
            '14 > length || length == null',
          ),
        );
      }
    }

    if (personal != null) {
      if (personal!.length > 13) {
        errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kPersonal, String, personal),
            'Personal phone length: ${personal!.length}, cannot exceed 13 characters',
            '14 > length || length == null',
          ),
        );
      }

      if(personal!.trim().isEmpty){
         errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kPersonal, String, personal),
            'Personal phone length: ${personal!.length}, cannot be empty if provided',
            '14 > length || length == null',
          ),
        );
      }
    }
    if (alternative != null) {
      if (alternative!.length > 30) {
        errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kAlternative, String, alternative),
            'Alternative contact length: ${alternative!.length}, cannot exceed 30 characters',
            '31 > length || length == null',
          ),
        );
      }
      if (alternative!.trim().isEmpty) {
        errors.add(
          EntityErrors<Approach>(
            this,
            PropertyInfo(kAlternative, String, alternative),
            'Alternative contact length: ${alternative!.length}, cannot be empty if provided',
            '31 > length || length == null',
          ),
        );
      }
    }
    
    errors.validateDependency(this, status);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Approach ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);
    
    if (email != ref.email) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEmail, String, email),
          email,
          ref.email,
          null,
        ),
      );
    }
    if (enterprise != ref.enterprise) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEnterprise, String, enterprise),
          enterprise,
          ref.enterprise,
          null,
        ),
      );
    }
    if (personal != ref.personal) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kPersonal, String, personal),
          personal,
          ref.personal,
          null,
        ),
      );
    }
    if (alternative != ref.alternative) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAlternative, String, alternative),
          alternative,
          ref.alternative,
          null,
        ),
      );
    }
    if (statusDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
       );
    }
    return aggregated;
  }
      
}
