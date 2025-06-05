import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/security/security/models/authentication_input.dart';

///
final class TestConfigs {
  ///
  static final AuthenticationInput localUser = AuthenticationInput.a(
    'TWSMF',
    'local_user',
    'local_user'.bytes,
  );  
}