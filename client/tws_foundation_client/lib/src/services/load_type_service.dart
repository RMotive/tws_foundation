import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class LoadTypeService extends LoadTypeServiceBase {
  LoadTypeService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'LoadTypes',
          client: client,
        );
        
  @override
  Effect<SetViewOut<LoadType>> view(SetViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<LoadType>>(actEffect);
  }
}
      