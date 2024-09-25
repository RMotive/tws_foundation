import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class SectionsServiceBase extends CSMServiceBase {
  SectionsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Section>> view(SetViewOptions<Section> options, String auth);

}
