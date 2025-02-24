import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

class MainResolver<TSuccess extends CSMEncodeInterface> extends CSMServiceResolverBase<TSuccess> {
  MainResolver(super.operationResult);

  Future<TSuccess> act(TSuccess Function(JObject json) decoder) async {
    late final TSuccess actResult;
    result.resolve(
      (JObject success) {
        final SuccessFrame<TSuccess> templateWithSuccess = SuccessFrame<TSuccess>.des(success, decoder);
        actResult = templateWithSuccess.estela;
      },
      (JObject failure, int statusCode) {
        final FailureFrame failureFrame = FailureFrame.des(failure);
        throw 'FailureException: server act resulted in failure $statusCode with (${failureFrame.estela.system})';
      },
      (Object exception, StackTrace trace) {
        throw exception;
      },
    );
    return actResult;
  }
  void resolve({
    required TSuccess Function(JObject json) decoder,
    required void Function(SuccessFrame<TSuccess> success) onSuccess,
    required void Function(FailureFrame failure, int status) onFailure,
    required void Function(Object exception, StackTrace trace) onException,
    required void Function() onConnectionFailure,
    void Function()? onFinally,
  }) {
    result.resolve(
      (JObject jSuccess) {
        final SuccessFrame<TSuccess> templateWithSuccess = SuccessFrame<TSuccess>.des(jSuccess, decoder);
        onSuccess(templateWithSuccess);
      },
      (JObject jFailure, int statusCode) {
        final FailureFrame templateWithFailure = FailureFrame.des(jFailure);
        onFailure(templateWithFailure, statusCode);
      },
      (Object exception, StackTrace trace) {
        if (exception.toString().contains('ClientException')) {
          onConnectionFailure.call();
        } else {
          onException.call(exception, trace);
        }
      },
    );
    onFinally?.call();
  }
}
