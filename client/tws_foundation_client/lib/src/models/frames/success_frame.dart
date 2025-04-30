import 'package:csm_client/csm_client.dart';

/// Data {class} implementation for an [FailureFrame].
///
///
/// [T] type of the response body data object.
///
/// Defines a data constract for a frame that represents a [ServerI] implementation successfuly response with interest data.
final class SuccessFrame<T extends DecodableI> implements DecodableI {
  /// Unique operation identifier.
  String tracer = '';

  /// Response data object.
  late T estela;

  /// Internal [T] builder for [DecodableI] purposes.
  final T Function() _estelaBuilder;

  /// Creates a new [SuccessFrame] instance.
  SuccessFrame(this._estelaBuilder) {
    estela = _estelaBuilder();
  }
  
  @override
  void decode(DataMap encode) {
    tracer = encode.get('tracer');

    final DataMap estelaData = encode.get('estela');
    estela = _estelaBuilder();
    estela.decode(estelaData);
  }
}
