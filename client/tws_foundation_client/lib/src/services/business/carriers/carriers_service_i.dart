import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [CarriersServiceI].
///
/// Defines base contract for [CarriersServiceI] implementations that specifies the methods to have providing [Carrier] based operations and management.
abstract interface class CarriersServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [CarriersServiceI] instance.
  CarriersServiceI(super.host, super.servicePath);


  /// Generates a complex [View] for [Carrier] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Carrier>> view(ViewInput<Carrier> input, String auth);
}
