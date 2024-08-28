import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class TrailersServiceBase extends CSMServiceBase {
  TrailersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<MigrationView<Trailer>> view(MigrationViewOptions options, String auth);

}
