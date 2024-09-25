import 'package:csm_client/csm_client.dart';

/// Represents a server exception exposed information.
final class ServerExceptionPublish {
  /// Identification of situation.
  final int situation;

  /// StackTrace from the exception source at server context.
  final String trace;

  /// User friendly advise message to display (recommended).
  final String advise;

  /// A system reflected type with message from the exception thrown at server context.
  final String system;

  /// A custom collection of data, this is custom per exception definition.
  final JObject factors;

  /// Generates a new [ServerExceptionPublish] object.
  const ServerExceptionPublish(this.situation, this.trace, this.advise, this.system, this.factors);

  /// Generates a new [ServerExceptionPublish] object based on a [JObject] deserealization.
  factory ServerExceptionPublish.des(JObject json) {
    int situation = json.get('situation');
    String trace = json.get('trace');
    String advise = json.get('advise');
    String system = json.get('system');
    JObject factors = json.getDefault('factors', <String, dynamic>{});

    return ServerExceptionPublish(situation, trace, advise, system, factors);
  }
}
