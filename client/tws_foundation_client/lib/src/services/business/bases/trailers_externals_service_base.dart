import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrailersExternalsServiceBase extends TWSServiceBase {
  TrailersExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TrailerExternal>> view(SetViewOptions<TrailerExternal> options, String auth);
}
