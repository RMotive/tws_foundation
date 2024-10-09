import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class SituationsServiceBase extends CSMServiceBase {
  SituationsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Situation>> view(SetViewOptions<Situation> options, String auth);

}
