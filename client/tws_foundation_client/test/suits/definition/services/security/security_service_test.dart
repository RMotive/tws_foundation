import 'dart:convert';
import 'dart:core' hide Uri;

import 'package:csm_client/csm_client.dart' show Client, DataMap, MockClient, Request, Response, StringExtension, Uri;
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/security/security/_security_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../test_utilities.dart';

void main() {
  late SecurityServiceI serviceMock;
  late ServerSession serverSessionMock;

  setUp(
    () {
      serverSessionMock = ServerSession();
      serverSessionMock.expiration = DateTime.now().toUtc();
      serverSessionMock.wildcard = true;
      serverSessionMock.token = 'test_token';
      serverSessionMock.identity = 'test_identity';

      final Client clientMock = MockClient(
        (Request request) async {
          DataMap dataMap = switch (request.url.pathSegments.last) {
            'authenticate' => TestUtilities.createSuccessFrameDataMap(serverSessionMock.encode()),
            _ => throw UnimplementedError(),
          };

          String object = jsonEncode(dataMap);
          return Response(object, 200);
        },
      );

      serviceMock = SecurityService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    'Security Service Tests',
    () {
      final AuthenticationInput input = AuthenticationInput();
      input.identity = 'test_identity';
      input.password = 'testing_password'.bytes;
      input.sign = 'twsmf';

      test(
        '[authenticate]: correctly gets {ServerSession} object',
        () async {
          final FoundationResponseResolver<ServerSession> resolver = await serviceMock.authenticate(input);
          final ServerSession serverSession = resolver.resolveDirect(() => ServerSession());

          expect(serverSession.token, serverSessionMock.token);
          expect(serverSession.identity, serverSessionMock.identity);
          expect(serverSession.wildcard, serverSessionMock.wildcard);
          expect(serverSession.expiration, serverSessionMock.expiration);
        },
      );
    },
  );
}
