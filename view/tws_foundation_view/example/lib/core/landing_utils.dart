import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class LandingUtils {
  ///
  static FutureOr<SessionData> authBuilder() async {
    SecurityServiceI securityService = Injector.get();

    FoundationResponseResolver<SessionData> resResolver = await securityService.authenticate(
      AuthenticationInput.a('TWSMF', 'local_user', 'local_user'.bytes),
    );

    SessionData sessionData = resResolver.resolveDirect(
      () => SessionData(),
    );

    return sessionData;
  }
}
