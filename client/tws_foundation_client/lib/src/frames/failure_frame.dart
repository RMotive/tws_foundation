import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Represents a standarized information for failures responses from the server source.
final class FailureFrame {
  /// Unique server transaction identification.
  final String tracer;

  /// Server exception reflection information.
  final ServerExceptionPublish estela;

  /// Generates a new failure frame response object.
  const FailureFrame(this.tracer, this.estela);

  factory FailureFrame.des(JObject json) {
    String tracer = json.get('tracer');
    JObject estelaJson = json.getDefault('estela', <String, dynamic>{});

    return FailureFrame(
      tracer,
      ServerExceptionPublish.des(estelaJson),
    );
  }
}
