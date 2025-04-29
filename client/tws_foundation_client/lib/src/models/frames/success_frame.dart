import 'package:csm_client/csm_client.dart';

/// Represents the success frame for responses from [TWSAdministration] source
/// exposing static properties from transaction contexts.
///
/// [TEstela] : Model object type that represents the transaction context result.
final class SuccessFrame<TEstela extends EncodableI> implements EncodableI {
  /// Unique transaction identifier.
  final String tracer;

  /// Transaction context object.
  final TEstela estela;

  /// Generates a new success frame object representation.
  const SuccessFrame(this.tracer, this.estela);

  /// Generates a new success frame object decoding a json object.
  factory SuccessFrame.des(DataMap json, TEstela Function(DataMap json) estelaDecoder) {
    String tracer = json.get('tracer');

    DataMap objEstela = json.get('estela', <String, dynamic>{});
    TEstela estelaObject = estelaDecoder(objEstela);

    return SuccessFrame<TEstela>(tracer, estelaObject);
  }

  @override
  DataMap encode() {
    return <String, dynamic>{
      'tracer': '',
      'estela': estela.encode(),
    };
  }
}
