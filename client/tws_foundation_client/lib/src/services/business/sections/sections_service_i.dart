import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SectionsServiceI].
///
/// Defines base contract for [SectionsServiceI] implementations that specifies the methods to have providing [Section] based operations and management.
abstract interface class SectionsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [SectionsServiceI] instance.
  SectionsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Section] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Section>> view(ViewInput<Section> input, String auth);

  /// Creates a [Section] collection.
  ///
  ///
  /// [sections] records to create and store. ([Section.Id] property must be 0, [Section.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<Section>> create(List<Section> sections, String auth);

  /// Updates a [Section] based on the [Section.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Section>> update(UpdateInput<Section> input, String auth);
}
