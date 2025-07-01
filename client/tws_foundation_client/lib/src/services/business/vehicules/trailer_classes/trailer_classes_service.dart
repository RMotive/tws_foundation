import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/trailer_classes/trailer_classes_service_b.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/trailer_classes/trailer_classes_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class TrailerClassesService extends TrailerClassesServiceB implements TrailerClassesServiceI {
  ///
  TrailerClassesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'TrailerClasses',
        );

  @override
  FoundationFutureResolver<ViewOutput<TrailerClass>> view(ViewInput<TrailerClass> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<TrailerClass>>(
      await postSecure<ViewInput<TrailerClass>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
