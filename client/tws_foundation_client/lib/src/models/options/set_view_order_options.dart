import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/enums/set_view_orerings.dart';

final class SetViewOrderOptions implements CSMEncodeInterface {
  final String property;
  final SetViewOrderings behavior;

  const SetViewOrderOptions(this.behavior, this.property);

  @override
  JObject encode() {
    return <String, dynamic>{
      'property': property,
      'behavior': behavior,
    };
  }
}
