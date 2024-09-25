import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

class MainResolver<TSuccess extends CSMEncodeInterface> extends CSMServiceResolverBase<TSuccess> {
  MainResolver(super.operationResult);

  Future<TSuccess> act([CSMDecodeInterface<TSuccess>? decoder]) async {
    late final TSuccess actResult;
    result.resolve(
      (JObject success) {
        if (decoder == null) {
          throw 'DependencyException: decoder is mandatory due to framing is generic abstracted';
        }

        CSMDecodeInterface<SuccessFrame<TSuccess>> frameDecoder = SuccessFrameDecode<TSuccess>(decoder);
        final SuccessFrame<TSuccess> templateWithSuccess = deserealize(success, decode: frameDecoder);
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
    required void Function() onConnectionFailure,
    required void Function(Object exception, StackTrace trace) onException,
    required void Function(FailureFrame failure, int status) onFailure,
    required void Function(SuccessFrame<TSuccess> success) onSuccess,
    void Function()? onFinally,
    CSMDecodeInterface<TSuccess>? decoder,
  }) {
    result.resolve(
      (JObject jSuccess) {
        if (decoder == null) {
          throw 'DependencyException: decoder is mandatory due to framing is generic abstracted';
        }

        CSMDecodeInterface<SuccessFrame<TSuccess>> frameDecoder = SuccessFrameDecode<TSuccess>(decoder);
        final SuccessFrame<TSuccess> templateWithSuccess = deserealize(jSuccess, decode: frameDecoder);
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
