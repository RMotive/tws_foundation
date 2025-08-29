import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [TrailerTypesServiceI].
///
/// Defines base contract for [LoadTypesServiceI] implementations that specifies the methods to have providing [TrailerType] based operations and management.
abstract interface class TrailerTypesServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<TrailerType> {
  /// Creates a new [LoadTypesServiceI] instance.
  TrailerTypesServiceI(
    super.host,
    super.servicePath,
  );
}

/// {abstract} class for [TrailerTypesServiceB].
///
/// Defines a base behavior for [TrailerTypesServiceB] implementations that are representations of a {TrailerTypesService} providing operations for the {Security} service at the [FoundationServer].
abstract class TrailerTypesServiceB extends FoundationServiceB implements TrailerTypesServiceI {
  /// Creates a new [LoadTypesServiceB] instance.
  TrailerTypesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {private} {implementation} class for [TrailerTypesService].
final class TrailerTypesService extends TrailerTypesServiceB {
  TrailerTypesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'trailerTypes',
        );

  @override
  FoundationFutureResolver<ViewOutput<TrailerType>> view(ViewInput<TrailerType> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<TrailerType>>(
      await postSecure<ViewInput<TrailerType>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
