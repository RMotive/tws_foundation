import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class LandingUtils {
  ///
  static FutureOr<SessionData> authBuilder() async {
    SecurityServiceI securityService = InjectorUtils.get();

    FoundationResponseResolver<SessionData> resResolver = await securityService.authenticate(
      AuthenticationInput.a('TWSMF', 'local_user', 'local_user'.bytes),
    );

    SessionData sessionData = resResolver.resolveDirect(
      () => SessionData(),
    );

    return sessionData;
  }
}
