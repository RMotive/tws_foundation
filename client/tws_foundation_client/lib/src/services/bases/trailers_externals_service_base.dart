import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class TrailersExternalsServiceBase extends CSMServiceBase {
  TrailersExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TrailerExternal>> view(SetViewOptions<TrailerExternal> options, String auth);

  Effect<SetBatchOut<TrailerExternal>> create(List<TrailerExternal> trailers, String auth);

  Effect<RecordUpdateOut<TrailerExternal>> update(TrailerExternal trailer, String auth);
}
