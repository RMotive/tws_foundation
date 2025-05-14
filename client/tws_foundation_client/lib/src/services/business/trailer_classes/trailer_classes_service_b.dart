import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [TrailerClass] entity service base
abstract class TrailerClassesServiceB extends FoundationServiceB {
  /// Creates a new [TrailerClassesServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  TrailerClassesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

}
