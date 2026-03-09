import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [LoadTypesServiceI].
///
/// Defines base contract for [LoadTypesServiceI] implementations that specifies the methods to have providing [LoadType] based operations and management.
abstract interface class LoadTypesServiceI extends FoundationServiceB implements IService, IViewService<LoadType, FoundationResponseResolver<ViewOutput<LoadType>>> {
  /// Creates a new [LoadTypesServiceI] instance.
  LoadTypesServiceI(super.host, super.servicePath);
}

/// {abstract} class for [LoadTypesServiceB].
///
/// Defines a base behavior for [LoadTypesServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class LoadTypesServiceB extends FoundationServiceB implements LoadTypesServiceI {
  /// Creates a new [LoadTypesServiceB] instance.
  LoadTypesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {private} {implementation} class for [LoadTypesService].
final class LoadTypesService extends LoadTypesServiceB {
  LoadTypesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'LoadTypes',
        );

  @override
  FoundationFutureResolver<ViewOutput<LoadType>> view(ViewInput<LoadType> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<LoadType>>(
      await postSecure<ViewInput<LoadType>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
