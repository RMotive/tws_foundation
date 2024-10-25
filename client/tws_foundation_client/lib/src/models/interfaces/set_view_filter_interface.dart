import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_node_interface.dart';

///
abstract interface class SetViewFilterInterface<TSet extends CSMSetInterface> implements SetViewFilterNodeInterface<TSet> {
  ///
  final String property;

  ///
  SetViewFilterInterface(this.property);
}
