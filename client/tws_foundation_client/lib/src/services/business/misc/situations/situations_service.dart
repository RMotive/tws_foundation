import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SituationsServiceI].
///
/// Defines base contract for [SituationsServiceI] implementations that specifies the methods to have providing [Situation] based operations and management.
abstract interface class SituationsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [SituationsServiceI] instance.
  SituationsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Situation] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Situation>> view(ViewInput<Situation> input, String auth);
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
          'situations',
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
