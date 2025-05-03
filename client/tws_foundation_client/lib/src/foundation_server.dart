import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/security/security/_security_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for a [ServerB].
///
///
/// Defines the base behavior for a [FoundationServer] that handles the network address to communicate with a [FoundationServer] and its [ServiceI] implementations.
final class FoundationServer extends ServerB {

  /// 
  late final SecurityServiceI securityService;

  /// Creates a new [FoundationServer] instance.
  FoundationServer({
    ServiceImplementationBuilder<SecurityServiceI>? securityServiceBuilder,
  })
      : super(
          Uri(
            'localhost',
            '',
            port: 5195,
          ),
        ) {
    securityService = securityServiceBuilder?.call(serverHost, httpClient) ?? SecurityService(serverHost, client: httpClient);
  }
}
