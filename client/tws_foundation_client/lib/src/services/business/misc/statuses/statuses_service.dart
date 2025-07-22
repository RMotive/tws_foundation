import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Defines a [ServiceI] contract for [Status] operations.
abstract interface class StatusesServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Status> {
  /// Creates a new [StatusesServiceI] instance.
  StatusesServiceI(
    super.host,
    super.servicePath,
  );
}

/// {abstract} class.
///
/// Implements base shared [StatusesServiceB] behavior for all [Status] based [ServiceI].
abstract class StatusesServiceB extends FoundationServiceB implements StatusesServiceI {
  /// Creates a new [StatusesServiceB] instance.
  ///
  ///
  /// [host] server host address.
  ///
  /// [servicePath] service path address.
  ///
  /// [client] custom network [Client] to testing/quality purposes.
  StatusesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// Implements a [ServiceI] for [Status] based operations, providing final behavior operations.
final class StatusesService extends StatusesServiceB {
  /// Creates a new [StatusesService] instance.
  StatusesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'statuses',
        );

  @override
  FoundationFutureResolver<ViewOutput<Status>> view(ViewInput<Status> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Status>>(
      await postSecure<ViewInput<Status>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}