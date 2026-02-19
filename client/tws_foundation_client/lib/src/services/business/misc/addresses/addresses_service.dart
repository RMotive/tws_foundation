import 'package:csm_client_core/csm_client_core.dart';
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

/// {interface} for [AddressServiceI].
///
/// Defines base contract for [AddressServiceI] implementations that specifies the methods to have providing [Address] based operations and management.
abstract interface class AddressServiceI extends FoundationServiceB implements IService {
  /// Creates a new [AddressServiceI] instance.
  AddressServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Address] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Address>> view(ViewInput<Address> input, String auth);
}

///
final class AddressesService extends AddressesServiceB {
  ///
  AddressesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Addresses',
        );

  @override
  FoundationFutureResolver<ViewOutput<Address>> view(ViewInput<Address> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Address>>(
      await postSecure<ViewInput<Address>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
