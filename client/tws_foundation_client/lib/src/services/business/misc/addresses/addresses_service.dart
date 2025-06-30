import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/addresses/addresses_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class AddressesService extends AddressesServiceB {
  ///
  AddressesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'Addresses',
        );

  @override
  FoundationFutureResolver<ViewOutput<Address>> view(ViewInput<Address> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Address>>(
      await postSecure<ViewInput<Address>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
