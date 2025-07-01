import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [TrailerTypesServiceI].
///
/// Defines base contract for [TrailerTypesServiceI] implementations that specifies the methods to have providing [TrailerType] based operations and management.
abstract interface class TrailerTypesServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [TrailerTypesServiceI] instance.
  TrailerTypesServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [TrailerType] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<TrailerType>> view(ViewInput<TrailerType> input, String auth);
}
