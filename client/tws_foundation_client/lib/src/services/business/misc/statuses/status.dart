import 'package:csm_client/csm_client.dart';

/// {entity} class.
///
/// Implements from [NamedEntityB], representing a {csm} business entity storing information
/// to represent a status for related entities.
final class Status extends NamedEntityB<Status> {
  /// Creates a new [Status] instance.
  Status();

  @override
  void decode(DataMap encode) {
    name;
    return super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode();
  }

  @override
  List<EntityInvalidation<Status>> evaluate() {
    return <EntityInvalidation<Status>>[];
  }
}
