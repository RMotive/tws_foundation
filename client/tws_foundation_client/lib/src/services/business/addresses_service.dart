import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AddressesService extends AddressesServiceBase {
  AddressesService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Addresses',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Address>> view(SetViewOptions<Address> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Address>>(actEffect);
  }
}
      