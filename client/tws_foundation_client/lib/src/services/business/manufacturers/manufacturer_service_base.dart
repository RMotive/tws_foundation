import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturer.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Manufacturer] entity service base
abstract class ManufacturerServiceBase extends FoundationServiceB {
  /// Creates a new [ManufacturerServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  ManufacturerServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<Manufacturer>> view(SetViewInput<Manufacturer> input, String auth);
}
