import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/situations/situation.dart';
import 'package:tws_foundation_client/src/services/business/situations/situations_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {private} {implementation} class for [SituationsService].
final class SituationsService extends SituationsServiceB {
  SituationsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'situations',
        );

  @override
  FoundationFutureResolver<ViewOutput<Situation>> view(ViewInput<Situation> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Situation>>(
      await postSecure<ViewInput<Situation>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

}
