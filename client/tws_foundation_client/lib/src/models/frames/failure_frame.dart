import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Data {class} implementation for an [FailureFrame].
///
///
/// Defines a data constract for a frame that represents a [ServerI] implementation failed response with [ExceptionInfo].
final class FailureFrame implements DecodableI {
  /// Unique server transaction identification.
  String tracer = '';

  /// Server exception reflection information.
  ExceptionInfo estela = ExceptionInfo();

  /// Creates a new [FailureFrame] instance.
  FailureFrame();
  
  @override
  void decode(DataMap encode) {
    tracer = encode.get('tracer');
    
    final DataMap estelaData = encode.get('estela');
    estela = ExceptionInfo();
    estela.decode(estelaData);
  }
}
