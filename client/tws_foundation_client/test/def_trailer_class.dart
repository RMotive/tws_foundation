import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/filters/set_view_filter_node_interface.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/operation_input.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_order_options.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contact.dart';
import 'package:tws_foundation_client/src/services/security/security/security_service.dart';
import 'package:tws_foundation_client/src/services/security/security/server_session.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  final FoundationServer source = FoundationServer();
  late String auth;
  late TrailerClassService service = TrailerClassService(source.devHost);
  
  setUp(
    () async {
      final SecurityService security = SecurityService(source.devHost);
      ResponseResolverB<ServerSession> resolver = await security.authenticate(qualityCredentials);
      resolver.controller.resolve(
        (DataMap success) {
          ServerSession session = ServerSession("", DateTime(0), "", false, Contact());
          session.decode(success);
          auth = session.token;
          // auth = success.estela.token;
        },
        (DataMap failure, int value) {

        },
        (TracedException ex) {

        },
      );
    },
  );

  test(
    'View',
    () async {
      ResponseResolverB<SetViewOutput<TrailerClass>> fact = await service.view(
        OperationalInput<TrailerClass>(
          SetViewInput<TrailerClass>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<TrailerClass>>[])
        ),
        auth,
      );
      fact.controller.resolve(
        (DataMap success) {
          SetViewOutput<TrailerClass> fact = SetViewOutput<TrailerClass>(<TrailerClass>[], 1, DateTime(0), 1, 1, 1);
          fact.decode(success);

          expect(fact.count >= fact.length, true);
          expect(fact.length >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.records.length, fact.length);
        },
        (DataMap failure, int value) {

        },
        (TracedException ex) {
          throw Exception(ex);
        },
      );
    },
  );
}