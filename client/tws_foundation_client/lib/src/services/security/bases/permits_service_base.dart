import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class PermitsServiceBase extends TWSServiceBase {
  PermitsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Permit>> view(SetViewOptions<Permit> options, String auth);

}
