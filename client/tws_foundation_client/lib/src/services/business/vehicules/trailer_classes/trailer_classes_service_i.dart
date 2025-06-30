import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [TrailerClassesServiceI].
///
/// Defines base contract for [TrailerClassesServiceI] implementations that specifies the methods to have providing [TrailerClass] based operations and management.
abstract interface class TrailerClassesServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [TrailerClassesServiceI] instance.
  TrailerClassesServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [TrailerClass] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<TrailerClass>> view(ViewInput<TrailerClass> input, String auth);
}
