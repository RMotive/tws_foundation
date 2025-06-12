import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/load_types/load_types_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {private} {implementation} class for [LoadTypesService].
final class LoadTypesService extends LoadTypesServiceB {
  LoadTypesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'loadtype',
        );

  @override
  FoundationFutureResolver<ViewOutput<LoadType>> view(ViewInput<LoadType> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<LoadType>>(
      await postSecure<ViewInput<LoadType>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
