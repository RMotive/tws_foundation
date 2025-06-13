import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [YardlogsServiceI].
///
/// Defines base contract for [YardlogsServiceI] implementations that specifies the methods to have providing [YardLog] based operations and management.
abstract interface class YardlogsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<YardLog> {
  /// Creates a new [YardlogsServiceI] instance.
  YardlogsServiceI(super.host, super.servicePath);

  /// Creates a [YardLog] collection.
  ///
  ///
  /// [yardLogs] records to create and store. ([YardLog.Id] property must be 0, [YardLog.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<YardLog>> create(List<YardLog> yardLogs, String auth);

  /// Updates a [YardLog] based on the [YardLog.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<YardLog>> update(UpdateInput<YardLog> input, String auth);
}
