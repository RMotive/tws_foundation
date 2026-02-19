import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [ManufacturersServiceI].
///
/// Defines base contract for [ManufacturersServiceI] implementations that specifies the methods to have providing [Manufacturer] based operations and management.
abstract interface class ManufacturersServiceI extends FoundationServiceB implements IService, ViewServiceI<Manufacturer> {
  /// Creates a new [ManufacturersServiceI] instance.
  ManufacturersServiceI(
    super.host,
    super.servicePath,
  );
}

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


/// {Service} class.
/// 
/// Implements a [ManufacturersServiceI] for [Manufacturer] based operations, providing final behavior operations.
final class ManufacturerService extends ManufacturersServiceB {
  ///
  ManufacturerService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'manufacturers',
        );

  @override
  FoundationFutureResolver<ViewOutput<Manufacturer>> view(ViewInput<Manufacturer> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Manufacturer>>(
      await postSecure<ViewInput<Manufacturer>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
