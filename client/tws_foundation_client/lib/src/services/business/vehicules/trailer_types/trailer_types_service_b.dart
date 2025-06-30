import 'package:tws_foundation_client/src/services/business/vehicules/trailer_types/trailer_types_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [TrailerType] entity service base
abstract class TrailerTypesServiceB extends FoundationServiceB implements TrailerTypesServiceI {
  /// Creates a new [TrailerTypesServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  TrailerTypesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
