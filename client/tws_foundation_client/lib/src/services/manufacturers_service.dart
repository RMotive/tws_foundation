import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class ManufacturersService extends ManufacturersServiceBase {
  ManufacturersService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Manufacturers',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Manufacturer>> view(SetViewOptions<Manufacturer> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Manufacturer>>(actEffect);
  }
}
      