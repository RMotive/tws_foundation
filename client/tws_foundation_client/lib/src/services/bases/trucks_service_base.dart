import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrucksServiceBase extends CSMServiceBase {
  TrucksServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<MigrationView<Truck>> view(MigrationViewOptions options, String auth);

  Effect<MigrationTransactionResult<Truck>> create(List<Truck> trucks, String auth);
}
