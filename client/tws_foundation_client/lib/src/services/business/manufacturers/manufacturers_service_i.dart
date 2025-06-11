import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [ManufacturersServiceI].
///
/// Defines base contract for [ManufacturersServiceI] implementations that specifies the methods to have providing [Manufacturer] based operations and management.
abstract interface class ManufacturersServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [ManufacturersServiceI] instance.
  ManufacturersServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Manufacturer] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Manufacturer>> view(ViewInput<Manufacturer> input, String auth);
}
