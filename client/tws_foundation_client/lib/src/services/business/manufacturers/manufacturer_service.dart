import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturer.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturer_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class ManufacturerService extends ManufacturerServiceBase {
  ///
  ManufacturerService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Manufacturers',
          client: client,
        );

  ///
  @override
  Effect<SetViewOutput<Manufacturer>> view(SetViewInput<Manufacturer> input, String auth) async {
    ResponseController actEffect = await postSecure('view', input, authToken: auth);

    return FoundationResponseResolver<SetViewOutput<Manufacturer>>(actEffect);
  }
}
