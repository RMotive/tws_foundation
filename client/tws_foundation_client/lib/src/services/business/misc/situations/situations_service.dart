import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SituationsServiceI].
///
/// Defines base contract for [SituationsServiceI] implementations that specifies the methods to have providing [Situation] based operations and management.
abstract interface class SituationsServiceI extends FoundationServiceB implements IService, IViewService<Situation, FoundationResponseResolver<ViewOutput<Situation>>> {
  /// Creates a new [SituationsServiceI] instance.
  SituationsServiceI(
    super.host,
    super.servicePath,
  );

}

/// {abstract} class for [SituationsServiceB].
///
/// Defines a base behavior for [SituationsServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class SituationsServiceB extends FoundationServiceB implements SituationsServiceI {
  /// Creates a new [SituationsServiceB] instance.
  SituationsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {private} {implementation} class for [SituationsService].
final class SituationsService extends SituationsServiceB {
  SituationsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Situations',
        );

  @override
  FoundationFutureResolver<ViewOutput<Situation>> view(ViewInput<Situation> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Situation>>(
      await postSecure<ViewInput<Situation>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
