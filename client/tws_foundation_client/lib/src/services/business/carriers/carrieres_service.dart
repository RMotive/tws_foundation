import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carrier.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carriers_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class CarrieresService extends CarriersServiceBase {
  ///
  CarrieresService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Carriers',
          client: client,
        );

  ///
  @override
  Effect<SetViewOutput<Carrier>> view(SetViewInput<Carrier> input, String auth) async {
    ResponseController actEffect = await postSecure('view', input, authToken: auth);

    return FoundationResponseResolver<SetViewOutput<Carrier>>(actEffect);
  }
}
