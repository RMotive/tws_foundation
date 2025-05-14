import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [AddressServiceI].
///
/// Defines base contract for [AddressServiceI] implementations that specifies the methods to have providing [Address] based operations and management.
abstract interface class AddressServiceI extends FoundationServiceB implements ServiceI {
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
