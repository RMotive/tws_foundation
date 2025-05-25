import 'package:tws_foundation_client/src/services/business/addresses/addresses_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Address] entity service base
abstract class AddressesServiceB extends FoundationServiceB implements AddressServiceI {
  /// Creates a new [AddressesServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  AddressesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

}
