import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturer_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Manufacturer] entity service base
abstract class ManufacturerServiceB extends FoundationServiceB implements ManufacturerServiceI {
  /// Creates a new [ManufacturerServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  ManufacturerServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
