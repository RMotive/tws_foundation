import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturers_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class ManufacturerService extends ManufacturersServiceB {
  ///
  ManufacturerService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'manufacturers',
        );

  @override
  FoundationFutureResolver<ViewOutput<Manufacturer>> view(ViewInput<Manufacturer> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Manufacturer>>(
      await postSecure<ViewInput<Manufacturer>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
