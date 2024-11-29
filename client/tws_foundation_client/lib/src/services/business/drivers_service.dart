import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriversService extends DriversServiceBase {
  DriversService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Drivers',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Driver>> view(SetViewOptions<Driver> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Driver>>(actEffect);
  }

  @override
  Effect<SetBatchOut<Driver>> create(List<Driver> drivers, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', drivers, auth: auth);
    return MainResolver<SetBatchOut<Driver>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<Driver>> update(Driver driver, String auth) async {
    CSMActEffect actEffect = await twsPost('update', driver, auth: auth);
    return MainResolver<RecordUpdateOut<Driver>>(actEffect);
  }

  
}
      