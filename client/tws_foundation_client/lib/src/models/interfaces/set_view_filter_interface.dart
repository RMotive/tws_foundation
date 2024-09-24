import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_node_interface.dart';

///
abstract interface class SetViewFilterInterface<TSet extends CSMSetInterface> implements SetViewFilterNodeInterface<TSet> {
  ///
  final String property;

  ///
  SetViewFilterInterface(this.property);
}
