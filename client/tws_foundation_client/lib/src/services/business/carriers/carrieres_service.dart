import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carriers_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class CarrieresService extends CarriersServiceBase {
  ///
  CarrieresService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Carriers',
        );


  @override
  FoundationFutureResolver<ViewOutput<Carrier>> view(ViewInput<Carrier> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Carrier>>(
      await postSecure<ViewInput<Carrier>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
