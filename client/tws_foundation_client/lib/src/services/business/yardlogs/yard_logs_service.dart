import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/create_service_i.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [YardLogsServiceI] implementation, wich is responsible to manage operations
/// related with [YardLog] entity at {Foundation Server}.
abstract interface class YardLogsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<YardLog>, CreateServiceI<YardLog> {
  /// Creates a new [YardLogsServiceI] instance.
  YardLogsServiceI(super.host, super.servicePath);

  /// Updates a [YardLog] based on the [YardLog.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<YardLog>> update(UpdateInput<YardLog> input, String auth);

  /// Updates a [YardLog] based on the [YardLog.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<YardLog> delete(YardLog entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [YardLogsServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class YardLogsServiceB extends FoundationServiceB implements YardLogsServiceI {
  /// Creates a new [YardLogsServiceB] instance.
  YardLogsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [YardLogsService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [YardLog] based operations.
final class YardLogsService extends YardLogsServiceB {
  /// Creates a new [YardLogsService] instance.
  YardLogsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'yardlogs',
        );

  @override
  FoundationFutureResolver<ViewOutput<YardLog>> view(ViewInput<YardLog> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<YardLog>>(
      await postSecure<ViewInput<YardLog>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<YardLog>> create(List<YardLog> yardlogs, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<YardLog>>(
      await postListSecure<YardLog>(
        'create',
        yardlogs,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<YardLog>> update(UpdateInput<YardLog> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<YardLog>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<YardLog> delete(YardLog entity, String authToken) async {
    return FoundationResponseResolver<YardLog>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
