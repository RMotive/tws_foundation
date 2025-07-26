import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// This class represents the contact information in the human resources domain.
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

  /// Creates a new [Approach] with specific values.
  Approach.a(this.email, this.personal, this.enterprise, this.alternative, this.status);

   /// Validate nulleable inputs to avoid [Approach] entities with empty values.
  Approach? sanitize({
    String? email,
    String? enterprise,
    String? personal,
    String? alternative,
  }){

    if(email != null) this.email = email;

    if(enterprise != null && enterprise.trim().isEmpty){
      this.enterprise = null;
      enterprise = null;
    }

    if(personal != null && personal.trim().isEmpty){
      this.personal = null;
      personal = null;
    }

    if(alternative != null && alternative.trim().isEmpty){
      this.alternative = null;
      alternative = null;
    }

    if (this.email.trim().isEmpty &&
        this.enterprise == null &&
        this.personal == null &&
        this.alternative == null) {
      return null;
    }

    return Approach.a(
      email ?? this.email, 
      enterprise ?? this.enterprise, 
      personal ?? this.personal, 
      alternative ?? this.alternative, 
      status,
    );
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

    if (email.trim().isEmpty || email.length > 64) {
      invalidations.add(
        EntityInvalidation<Approach>(
          this,
          PropertyInfo(kEmail, String, email),
          'Email length cannot exceed 64 characters or be empty',
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
