import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Data {class} implementation for an [ExceptionInfo].
///
///
/// Defines a data constract for a [FoundationServer] implementation exception, storing diagnosticable exception information.
final class ExceptionInfo implements DecodableI {
  /// Where the exception got thrown ([ServerI] side).
  String trace = '';

  /// Specific exception management situation code.
  int situation = 0;

  /// User friendly advise message to display (recommended).
  String advise = '';

  /// A system reflected type with message from the exception thrown at server context.
  String system = '';

  /// A custom collection of data, this is custom per exception definition.
  DataMap factors = <String, Object?>{};

  /// Generates a new [ExceptionInfo] object.
  ExceptionInfo();

  @override
  void decode(DataMap encode) {
    situation = encode.get('situation');
    trace = encode.get('trace');
    advise = encode.get('advise');
    system = encode.get('system');
    factors = encode.get('factors');
  }
}
