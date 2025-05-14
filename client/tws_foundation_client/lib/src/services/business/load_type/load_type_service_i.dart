import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [LoadtypeServiceI].
///
/// Defines base contract for [LoadtypeServiceI] implementations that specifies the methods to have providing [Loadtype] based operations and management.
abstract interface class LoadtypeServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [LoadtypeServiceI] instance.
  LoadtypeServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Loadtype] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Loadtype>> view(ViewInput<Loadtype> input, String auth);

}
