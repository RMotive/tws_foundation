import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/load_type/load_type_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {private} {implementation} class for [LoadTypeService].
final class LoadTypeService extends LoadTypeServiceB {
  LoadTypeService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'loadtype',
        );

  @override
  FoundationFutureResolver<ViewOutput<Loadtype>> view(ViewInput<Loadtype> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Loadtype>>(
      await postSecure<ViewInput<Loadtype>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
