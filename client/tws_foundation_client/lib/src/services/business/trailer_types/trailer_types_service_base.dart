import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [TrailerType] entity service base
abstract class TrailerTypesServiceBase extends FoundationServiceB {
  /// Creates a new [TrailerTypesServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  TrailerTypesServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<TrailerType>> view(SetViewInput<TrailerType> input, String auth);
}
