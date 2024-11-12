import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class VehiculesModelsService extends VehiculesModelsServiceBase {
  VehiculesModelsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'VehiculesModels',
          client: client,
        );
        
  @override
  Effect<SetViewOut<VehiculeModel>> view(SetViewOptions<VehiculeModel> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<VehiculeModel>>(actEffect);
  }
}
      