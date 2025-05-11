import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carrier.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Carrier] entity service base
abstract class CarriersServiceBase extends FoundationServiceB {
  /// Creates a new [CarriersServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  CarriersServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<Carrier>> view(SetViewInput<Carrier> input, String auth);
}
