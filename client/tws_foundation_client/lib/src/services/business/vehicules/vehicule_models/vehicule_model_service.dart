import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/vehicule_models/vehicule_model_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class VehiculeModelService extends VehiculeModelServiceB {
  ///
  VehiculeModelService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'vehiculeModels',
        );

  @override
  FoundationFutureResolver<ViewOutput<VehiculeModel>> view(ViewInput<VehiculeModel> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<VehiculeModel>>(
      await postSecure<ViewInput<VehiculeModel>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
