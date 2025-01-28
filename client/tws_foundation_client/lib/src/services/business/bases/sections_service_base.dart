import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class SectionsServiceBase extends TWSServiceBase {
  SectionsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Section>> view(SetViewOptions<Section> options, String auth);

  /// Transaction to create a set view object.
  Effect<SetBatchOut<Section>> create(List<Section> sections, String auth);

  /// Transaction to update a set object.
  Effect<RecordUpdateOut<Section>> update(Section section, String auth);

}
