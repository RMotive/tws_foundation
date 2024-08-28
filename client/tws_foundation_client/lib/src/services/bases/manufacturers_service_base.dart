import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class ManufacturersServiceBase extends CSMServiceBase {
  ManufacturersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<MigrationView<Manufacturer>> view(MigrationViewOptions options, String auth);

}
