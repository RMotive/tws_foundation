import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SectionsService extends SectionsServiceBase {
  SectionsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Sections',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Section>> view(SetViewOptions<Section> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Section>>(actEffect);
  }
  
  @override
  Effect<SetBatchOut<Section>> create(List<Section> sections, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', sections, auth: auth);
    return MainResolver<SetBatchOut<Section>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<Section>> update(Section section, String auth) async {
    CSMActEffect actEffect = await twsPost('update', section, auth: auth);
    return MainResolver<RecordUpdateOut<Section>>(actEffect);
  }
}
      