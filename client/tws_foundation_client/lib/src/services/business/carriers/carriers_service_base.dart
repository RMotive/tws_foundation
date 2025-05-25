import 'package:tws_foundation_client/src/services/business/carriers/carriers_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Carrier] entity service base
abstract class CarriersServiceBase extends FoundationServiceB implements CarriersServiceI {
  /// Creates a new [CarriersServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  CarriersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

}
