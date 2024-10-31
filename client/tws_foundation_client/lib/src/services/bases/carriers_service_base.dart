import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class CarriersServiceBase extends CSMServiceBase {
  CarriersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Carrier>> view(SetViewOptions<Carrier> options, String auth);

}
