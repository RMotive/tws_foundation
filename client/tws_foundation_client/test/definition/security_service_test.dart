import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/core/constants/context_constants.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late final Privileges privilegesMock;
  late final Credentials credentialsMock;
  late final SecurityServiceBase service;

  setUp(
    () {
      Contact contact = Contact(1, "Enrique", "Segoviano", "Eseg@gmail.com", "+526657141230");
      privilegesMock = Privileges('random-guid', DateTime.now(), 'tws-dev', true, contact);
      credentialsMock = Credentials('', Uint8List.fromList(<int>[]), ContextConstants.sign);

      Client mockClient = MockClient(
        (Request request) async {
          SuccessFrame<Privileges> mockFrame = SuccessFrame<Privileges>('random-tracer', privilegesMock);
          JObject jObject = mockFrame.encode();
          String object = jsonEncode(jObject);

          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).security;
    },
  );

  test(
    'Authenticate',
    () async {
      MainResolver<Privileges> fact = await service.authenticate(credentialsMock);

      fact.resolve(
        decoder: PrivilegesDecode(),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onSuccess: (SuccessFrame<Privileges> success) {
          Privileges fact = success.estela;
          expect(fact.expiration, privilegesMock.expiration);
          expect(fact.identity, privilegesMock.identity);
          expect(fact.token, privilegesMock.token);
          expect(fact.wildcard, privilegesMock.wildcard);
        },
      );
    },
  );
}
