import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class TrailersTypesServiceBase extends TWSServiceBase {
  TrailersTypesServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TrailerType>> view(SetViewOptions<TrailerType> options, String auth);

}
