import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/locations/locations_service_b.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class LocationsService extends LocationsServiceBase {
  ///
  LocationsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'locations',
        );

  @override
  FoundationFutureResolver<ViewOutput<Location>> view(ViewInput<Location> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Location>>(
      await postSecure<ViewInput<Location>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Location>> create(List<Location> locations, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Location>>(
      await postListSecure<Location>(
        'create',
        locations,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Location>> update(UpdateInput<Location> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Location>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
