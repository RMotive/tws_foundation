import 'package:csm_client/csm_client.dart';

///
abstract interface class SetViewFilterNodeInterface<TSet extends EntityI> implements EncodableI {
  ///
  final String discrimination;

  ///
  final int order;

  SetViewFilterNodeInterface(this.discrimination, this.order);
}
