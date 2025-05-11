import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/locations/location.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Location] entity service base
abstract class LocationsServiceBase extends FoundationServiceB {
  /// Creates a new [LocationsServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  LocationsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<Location>> view(SetViewInput<Location> input, String auth);
}
