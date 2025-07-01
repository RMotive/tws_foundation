import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/trailer_types/trailer_types_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class TrailerTypesService extends TrailerTypesServiceB {
  ///
  TrailerTypesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'TrailerTypes',
        );

  @override
  FoundationFutureResolver<ViewOutput<TrailerType>> view(ViewInput<TrailerType> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<TrailerType>>(
      await postSecure<ViewInput<TrailerType>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
