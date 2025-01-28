import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailersExternalsService extends TrailersExternalsServiceBase {
  TrailersExternalsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrailersExternals',
          client: client,
        );
        
  @override
  Effect<SetViewOut<TrailerExternal>> view(SetViewOptions<TrailerExternal> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<TrailerExternal>>(actEffect);
  }

  @override
  Effect<SetBatchOut<TrailerExternal>> create(List<TrailerExternal> trailers, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', trailers, auth: auth);
    return MainResolver<SetBatchOut<TrailerExternal>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<TrailerExternal>> update(TrailerExternal trailer, String auth) async {
    CSMActEffect actEffect = await twsPost('update', trailer, auth: auth);
    return MainResolver<RecordUpdateOut<TrailerExternal>>(actEffect);
  }
}
      