import 'package:tws_foundation_client/src/services/business/vehicules/manufacturers/manufacturers_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Manufacturer] entity service base
abstract class ManufacturersServiceB extends FoundationServiceB implements ManufacturersServiceI {
  /// Creates a new [ManufacturersServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  ManufacturersServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
