import 'package:tws_foundation_client/src/services/business/misc/sections/sections_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Section] entity service base
abstract class SectionsServiceB extends FoundationServiceB implements SectionsServiceI {
  /// Creates a new [SectionsServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  SectionsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
