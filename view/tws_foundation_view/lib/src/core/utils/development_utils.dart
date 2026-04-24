import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

class _MixinUtils with ConsoleMixin {}

class DevelopmentUtils {
  static Future<void> configure(String sign) async {
    await _configureAccount(sign);
  }

  static Future<void> _configureAccount(String sign) async {
    final SessionStorage sessionStorage = InjectorUtils.get();
    final SecurityServiceI securityService = InjectorUtils.get();

    if (sessionStorage.isActive) {
      _MixinUtils().successLog(
        "development, Pre configured from SessionStorage",
        info: <String, dynamic>{
          'token': sessionStorage.token,
          'expiration': sessionStorage.expiration?.toIso8601String()
        },
      );

      return;
    }

    final FoundationResponseResolver<SessionData> authResolver = await securityService
        .authenticate(
          AuthenticationInput.a(
            sign,
            'local_user',
            'local_user'.toByteArray(),
          ),
        )
        .timeout(6.seconds);

    SessionData serverSession = authResolver.resolveDirect(
      () => SessionData(),
    );

    sessionStorage.store(serverSession);
  }
}
