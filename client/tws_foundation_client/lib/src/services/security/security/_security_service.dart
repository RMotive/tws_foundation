import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// (private) {implementation} class for [SecurityService].
///
/// Defines final implementation behavior from [SecurityServiceB] representing the native built-in [FoundationServer]
/// {Security} related service operations.
final class SecurityService extends SecurityServiceB {
  /// Creates a new [SecurityService] instance.
  SecurityService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'security',
        );

  @override
  FoundationFutureResolver<SessionData> authenticate(
      AuthenticationInput input) async {
    final ResponseControllerI controller =
        await postSecure('authenticate', input);
    return FoundationResponseResolver<SessionData>(controller);
  }
}
