import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/services/read_reference_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Defines a [IService] contract for [Status] operations.
abstract interface class StatusesServiceI extends FoundationServiceB implements IService, ViewServiceI<Status>, ReadReferenceServiceI<Status> {
  /// Creates a new [StatusesServiceI] instance.
  StatusesServiceI(
    super.host,
    super.servicePath,
  );
}

/// {abstract} class.
///
/// Implements base shared [StatusesServiceB] behavior for all [Status] based [IService].
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
/// Implements a [IService] for [Status] based operations, providing final behavior operations.
final class StatusesService extends StatusesServiceB {
  /// Creates a new [StatusesService] instance.
  StatusesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Statuses',
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

  @override
  FoundationFutureResolver<Status?> read(String reference, String auth) async {
    return FoundationResponseResolver<Status?>(
      await getSecure(
        'Read/$reference',
        auth,
      ),
    );
  }
}
