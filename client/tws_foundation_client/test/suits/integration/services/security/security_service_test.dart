import 'dart:core' hide Uri;

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../test_configs.dart' show TestConfigs;

void main() {
  late SecurityServiceI serviceMock;

  setUp(
    () {
      serviceMock = FoundationServer(false).securityService;
    },
  );

  group(
    '[Integration] Security Service Tests',
    () {
      final AuthenticationInput input = TestConfigs.qualityAuth;

      test(
        '[authenticate]: correctly gets {ServerSession} object',
        () async {
          final FoundationResponseResolver<SessionData> resolver = await serviceMock.authenticate(input);
          final SessionData serverSession = resolver.resolveDirect(() => SessionData());

          expect(serverSession.token, isNotEmpty);
          expect(serverSession.identity, input.identity);
          expect(serverSession.wildcard, true);
        },
      );
    },
  );
}
