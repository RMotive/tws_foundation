import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrucksExternalsService extends TrucksExternalsServiceBase {
  TrucksExternalsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrucksExternals',
          client: client,
        );
        
  @override
  Effect<SetViewOut<TruckExternal>> view(SetViewOptions<TruckExternal> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<TruckExternal>>(actEffect);
  }

  @override
  Effect<SetBatchOut<TruckExternal>> create(List<TruckExternal> trucks, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', trucks, auth: auth);
    return MainResolver<SetBatchOut<TruckExternal>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<TruckExternal>> update(TruckExternal truck, String auth) async {
    CSMActEffect actEffect = await twsPost('update', truck, auth: auth);
    return MainResolver<RecordUpdateOut<TruckExternal>>(actEffect);
  }
}
      