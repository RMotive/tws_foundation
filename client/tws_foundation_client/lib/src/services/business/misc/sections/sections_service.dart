import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SectionsServiceI].
///
/// Defines base contract for [SectionsServiceI] implementations that specifies the methods to have providing [Section] based operations and management.
abstract interface class SectionsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Section> {
  /// Creates a new [SectionsServiceI] instance.
  SectionsServiceI(
    super.host,
    super.servicePath,
  );

}

/// {abstract} class for [SectionsServiceB].
///
/// Defines a base behavior for [SectionsServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class SectionsServiceB extends FoundationServiceB implements SectionsServiceI {
  /// Creates a new [SectionsServiceB] instance.
  SectionsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {private} {implementation} class for [SectionsService].
final class SectionsService extends SectionsServiceB {
  SectionsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'sections',
        );

  @override
  FoundationFutureResolver<ViewOutput<Section>> view(ViewInput<Section> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Section>>(
      await postSecure<ViewInput<Section>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
