import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


final class ProfileService extends ProfileServiceBase {
  ProfileService(
    CSMUri host, {
    Client? client,
    CSMHeaders? headers,
  }) : super(
          host,
          'Profiles',
          client: client,
          headers: headers,
        );

  @override
  Effect<SetViewOut<Profile>> view(SetViewOptions<Profile> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Profile>>(actEffect);
  }
}
