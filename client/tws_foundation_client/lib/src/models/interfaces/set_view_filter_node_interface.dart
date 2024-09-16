import 'package:csm_foundation_services/csm_foundation_services.dart';

///
abstract interface class SetViewFilterNodeInterface<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  ///
  final String discrimination;

  ///
  final int order;

  SetViewFilterNodeInterface(this.discrimination, this.order);
}
