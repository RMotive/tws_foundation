import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class LoadTypeServiceBase extends CSMServiceBase {
  LoadTypeServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<LoadType>> view(SetViewOptions<LoadType> options, String auth);

}
