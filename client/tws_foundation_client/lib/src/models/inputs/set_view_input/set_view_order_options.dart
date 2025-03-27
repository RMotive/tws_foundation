import 'package:csm_client/csm_client.dart';

/// Stores the options to order a [View] based on a [Set] context. 
final class SetViewOrderOptions implements CSMEncodeInterface {
  /// Property path from the context object to order.
  final String property;

  /// How the ordering will behave.
  final SetViewOrderings behavior;

  /// Generates a new [SetViewOrderOptions] object, storing a instruction for the [View] operation over how order the resulted items.
  const SetViewOrderOptions(this.behavior, this.property);

  @override
  JObject encode() {
    return <String, dynamic>{
      'property': property,
      'behavior': behavior.index,
    };
  }
}

/// Available ordering behaviors for [SetViewOrderOptions] instructions.
enum SetViewOrderings {
  /// Indicates ascending ordering.
  ascending,

  /// Indicates descending ordering.
  descending,
}
