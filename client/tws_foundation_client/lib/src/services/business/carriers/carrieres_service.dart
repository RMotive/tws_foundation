import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [CarriersServiceI].
///
/// Defines base contract for [CarriersServiceI] implementations that specifies the methods to have providing [Carrier] based operations and management.
abstract interface class CarriersServiceI extends FoundationServiceB implements IService, IViewService<Carrier, ResponseResolverBase<ViewOutput<Carrier>>> {
  /// Creates a new [CarriersServiceI] instance.
  CarriersServiceI(
    super.host,
    super.servicePath,
  );
}


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


/// {service} class.
/// 
/// Implements a [CarriersServiceI] for [Carrier] based operations, providing final behavior operations.
final class CarrieresService extends CarriersServiceBase {
  ///
  CarrieresService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Carriers',
        );

  @override
  FoundationFutureResolver<ViewOutput<Carrier>> view(
      ViewInput<Carrier> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Carrier>>(
      await postSecure<ViewInput<Carrier>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
  
}
