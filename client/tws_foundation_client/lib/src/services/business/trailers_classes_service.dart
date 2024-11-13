import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/bases/trailers_classes_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailersClassesService extends TrailersClassesServiceBase {
  TrailersClassesService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrailersClasses',
          client: client,
        );
        
  @override
  Effect<SetViewOut<TrailerClass>> view(SetViewOptions<TrailerClass> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<TrailerClass>>(actEffect);
  }
}
      