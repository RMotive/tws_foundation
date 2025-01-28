import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrailersServiceBase extends TWSServiceBase {
  TrailersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Trailer>> view(SetViewOptions<Trailer> options, String auth);
    
  Effect<SetBatchOut<Trailer>> create(List<Trailer> trailers, String auth);

  Effect<RecordUpdateOut<Trailer>> update(Trailer trailer, String auth);

}
