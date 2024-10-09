import 'package:csm_client/csm_client.dart';
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
  Effect<SetViewOut<LoadType>> view(SetViewOptions<LoadType> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<LoadType>>(actEffect);
  }
}
      