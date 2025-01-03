import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class LocationsService extends LocationsServiceBase {
  LocationsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Locations',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Location>> view(SetViewOptions<Location> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Location>>(actEffect);
  }

  @override
  Effect<SetBatchOut<Location>> create(List<Location> locations, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', locations, auth: auth);
    return MainResolver<SetBatchOut<Location>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<Location>> update(Location location, String auth) async {
    CSMActEffect actEffect = await twsPost('update', location, auth: auth);
    return MainResolver<RecordUpdateOut<Location>>(actEffect);
  }

  
}
      