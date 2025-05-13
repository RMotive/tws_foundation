import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';

/// Generates a View for [Tset].
final class OperationalInput<TSet extends EntityI<TSet>> implements EncodableI {
  /// View behaviors parameters.
  SetViewInput<TSet> parameters;

  /// Creates a new [SetViewInput] instance.
  OperationalInput(this.parameters);
  
  @override
  DataMap encode() {
    return <String, dynamic>{
      'parameters': parameters.encode(),
    };
  }


}
