import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SituationsServiceI].
///
/// Defines base contract for [SituationsServiceI] implementations that specifies the methods to have providing [Situation] based operations and management.
abstract interface class SituationsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [SituationsServiceI] instance.
  SituationsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Situation] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Situation>> view(ViewInput<Situation> input, String auth);
}
