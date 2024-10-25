import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class DriversServiceBase extends CSMServiceBase {
  DriversServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Driver>> view(SetViewOptions<Driver> options, String auth);

}
