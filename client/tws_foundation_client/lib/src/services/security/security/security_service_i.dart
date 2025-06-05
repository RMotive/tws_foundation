import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SecurityServiceI].
///
/// Defines a base contract for [SecurityServiceI] implementations taht represents a {Security} operations
/// service operations provider from [FoundationServer].
abstract interface class SecurityServiceI extends FoundationServiceB implements ServiceI {
  SecurityServiceI(super.host, super.servicePath);

  /// Authenticates an user into [FoundationServer].
  ///
  ///
  /// [input] operation input parameters.
  FoundationFutureResolver<SessionData> authenticate(AuthenticationInput input);
}
