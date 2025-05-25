import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
extension ViewFilterNodesCollection<T extends EntityI<T>> on List<ViewFilterNodeI<T>> {
  ///
  List<DataMap> encode() {
    return map(
      (ViewFilterNodeI<T> el) => el.encode(),
    ).toList();
  }
}

///
extension ViewOrderingCollection on List<ViewOrdering> {
  ///
  List<DataMap> encode() {
    return map(
      (ViewOrdering el) => el.encode(),
    ).toList();
  }
}

///
extension EntityCollection<T extends EntityI<T>> on List<T> {
  ///
  List<DataMap> encode() {
    return map((T el) => el.encode()).toList();
  }
}

///
extension EntityOperationFailureCollection<T extends EntityI<T>> on List<EntityOperationFailure<T>> {
  ///
  List<DataMap> encode() {
    return map(
      (EntityOperationFailure<T> e) => e.encode(),
    ).toList();
  }
}
