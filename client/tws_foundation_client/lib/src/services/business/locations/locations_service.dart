import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/locations/location.dart';
import 'package:tws_foundation_client/src/services/business/locations/locations_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class LocationsService extends LocationsServiceBase {
  ///
  LocationsService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Locations',
          client: client,
        );

  ///
  @override
  Effect<SetViewOutput<Location>> view(SetViewInput<Location> input, String auth) async {
    ResponseController actEffect = await postSecure('view', input, authToken: auth);

    return FoundationResponseResolver<SetViewOutput<Location>>(actEffect);
  }
}
