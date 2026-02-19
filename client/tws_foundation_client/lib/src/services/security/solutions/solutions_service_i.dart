import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SolutionsServiceI].
///
/// Defines base contract for [SolutionsServiceI] implementations that specifies the methods to have providing [Solution] based operations and management.
abstract interface class SolutionsServiceI extends FoundationServiceB implements IService, ViewServiceI<Solution>, CreateServiceI<Solution> {
  /// Creates a new [SolutionsServiceI] instance.
  SolutionsServiceI(super.host, super.servicePath);

  /// Updates a [Solution] based on the [Solution.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Solution>> update(UpdateInput<Solution> input, String auth);
}
