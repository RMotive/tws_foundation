import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [LocationsServiceI].
///
/// Defines base contract for [LocationsServiceI] implementations that specifies the methods to have providing [Location] based operations and management.
abstract interface class LocationsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [LocationsServiceI] instance.
  LocationsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Location] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Location>> view(ViewInput<Location> input, String auth);

  /// Creates a [Location] collection.
  ///
  ///
  /// [locations] records to create and store. ([Location.Id] property must be 0, [Location.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<Location>> create(List<Location> locations, String auth);

  /// Updates a [Location] based on the [Location.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Location>> update(UpdateInput<Location> input, String auth);

}
