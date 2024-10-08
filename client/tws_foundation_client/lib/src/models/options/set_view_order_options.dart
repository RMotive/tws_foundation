import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/enums/migration_view_order_behaviors.dart';

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
