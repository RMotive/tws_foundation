import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [LoadTypesServiceI].
///
/// Defines base contract for [LoadTypesServiceI] implementations that specifies the methods to have providing [LoadType] based operations and management.
abstract interface class LoadTypesServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [LoadTypesServiceI] instance.
  LoadTypesServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [LoadType] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<LoadType>> view(ViewInput<LoadType> input, String auth);
}
