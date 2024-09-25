import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrucksService extends TrucksServiceBase {
  TrucksService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Trucks',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Truck>> view(SetViewOptions<Truck> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Truck>>(actEffect);
  }
  
  @override
  Effect<MigrationTransactionResult<Truck>> create(List<Truck> trucks, String auth) async {
    CSMActEffect actEffect = await postList('create', trucks, auth: auth);
    return MainResolver<MigrationTransactionResult<Truck>>(actEffect);
  }
}
      
