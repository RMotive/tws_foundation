import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Data {class} implementation for an [FailureFrame].
///
///
/// Defines a data constract for a frame that represents a [ServerI] implementation failed response with [ExceptionInfo].
final class FailureFrame implements DecodableI {
  /// Unique server transaction identification.
  String id = '';

  /// Server exception reflection information.
  ExceptionInfo content = ExceptionInfo();

  /// Creates a new [FailureFrame] instance.
  FailureFrame();
  
  @override
  void decode(DataMap encode) {
    id = encode.get('id');
    
    final DataMap estelaData = encode.get('content');
    content = ExceptionInfo();
    content.decode(estelaData);
  }
}
