import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [TrucksServiceI].
///
/// Defines base contract for [TrucksServiceI] implementations that specifies the methods to have providing [Truck] based operations and management.
abstract interface class TrucksServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [TrucksServiceI] instance.
  TrucksServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Truck] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Truck>> view(ViewInput<Truck> input, String auth);

  /// Creates a [Truck] collection.
  ///
  ///
  /// [trucks] records to create and store. ([Truck.Id] property must be 0, [Truck.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<Truck>> create(List<Truck> trucks, String auth);

  /// Updates a [Truck] based on the [Truck.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Truck>> update(UpdateInput<Truck> input, String auth);
}
