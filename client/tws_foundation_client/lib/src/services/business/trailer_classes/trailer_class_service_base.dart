import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/operation_input.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [TrailerClass] entity service base
abstract class TrailerClassServiceBase extends FoundationServiceB {
  /// Creates a new [TrailerClassServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  TrailerClassServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<TrailerClass>> view(OperationalInput<TrailerClass> input, String auth);
}
