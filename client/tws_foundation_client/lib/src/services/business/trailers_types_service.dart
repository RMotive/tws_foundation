import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/bases/trailers_types_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailersTypesService extends TrailersTypesServiceBase {
  TrailersTypesService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrailersTypes',
          client: client,
        );
        
  @override
  Effect<SetViewOut<TrailerType>> view(SetViewOptions<TrailerType> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<TrailerType>>(actEffect);
  }
}
      