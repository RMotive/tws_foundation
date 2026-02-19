import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [TrailerClassesServiceI].
///
/// Defines base contract for [TrailerClassesServiceI] implementations that specifies the methods to have providing [TrailerClass] based operations and management.
abstract interface class TrailerClassesServiceI extends FoundationServiceB implements IService, ViewServiceI<TrailerClass> {
  /// Creates a new [TrailerClassesServiceI] instance.
  TrailerClassesServiceI(super.host, super.servicePath);
}

/// {abstract} class for [TrailerClassesServiceB].
///
/// Defines a base behavior for [TrailerClassesServiceB] implementations that are representations of a {TrailerClassesService} providing operations for the {Security} service at the [FoundationServer].
abstract class TrailerClassesServiceB extends FoundationServiceB implements TrailerClassesServiceI {
  /// Creates a new [TrailerClassesServiceB] instance.
  TrailerClassesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {private} {implementation} class for [TrailerClassesServiceB].
final class TrailerClassesService extends TrailerClassesServiceB {
  TrailerClassesService (
    Uri host, {
    super.client,
  }) : super(
          host,
          'trailerClasses',
        );

  @override
  FoundationFutureResolver<ViewOutput<TrailerClass>> view(ViewInput<TrailerClass> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<TrailerClass>>(
      await postSecure<ViewInput<TrailerClass>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
