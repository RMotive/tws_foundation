import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class from a [ResponseResolverB].
///
///
/// Defines final behavior for a [FoundationResponseResolver] wich handles [ServiceI] requests implementations from a [FoundationServer] and [FoundationServiceB], resolving
/// as a {Foundation} package scope the [ServerI] implementation responses as needed.
final class FoundationResponseResolver<T extends DecodableI?> extends ResponseResolverB<T> {
  /// Creates a new [FoundationResponseResolver] instance.
  const FoundationResponseResolver(super.controller);

  /// Resolves the [ResponseController] directly with no callback handlers.
  ///
  ///
  /// [objectBuilder] building callback for the [T] object creation in order to call [DecodableI.decode] method from [DecodableI] interface.
  T resolveDirect(T Function() objectBuilder) {
    T? result;
    responseController.resolve(
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<T> successFrame = SuccessFrame<T>(objectBuilder);
        successFrame.decode(data);

        result = successFrame.content;
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);
        throw TracedException(
            'FailureException: server act resulted in failure $statusCode with (${failureFrame.content.system})',
            StackTrace.current);
      },
      (TracedException exception) {
        throw exception;
      },
    );

    if (result == null && (null is! T)) {
      throw TracedException('Unable to resolve response controller', StackTrace.current);
    }

    return result as T;
  }

  /// Resolves the [ResponseController] with the given callback handlers.
  ///
  ///
  /// [objectBuilder] building callback for the [T] object creation in order to call [DecodableI.decode] method from [DecodableI] interface.
  ///
  /// [onSuccess] callback invoked when the [ResponseController] resulted in a success.
  ///
  /// [onFailure] callback invoked when the [ResponseController] resulted in a server failure.
  ///
  /// [onException] callback invoked when the [ResponseController] resulted in a client-side exception.
  ///
  /// [onConnectionFailure] callback invoked when the [ResponseController] resulted in an exception related with connection failure.
  ///
  /// [onFinally] callback invoked after any [ResponseController] result and callback invokation.
  void resolve({
    required T Function() objectBuilder,
    required void Function(SuccessFrame<T> success) onSuccess,
    required void Function(FailureFrame failure, int status) onFailure,
    required void Function(TracedException exception) onException,
    required void Function() onConnectionFailure,
    void Function()? onFinally,
  }) {
    responseController.resolve(
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<T> successFrame = SuccessFrame<T>(objectBuilder);
        successFrame.decode(data);
        onSuccess(successFrame);
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);

        onFailure(failureFrame, statusCode);
      },
      (TracedException exception) {
        if (exception.toString().contains('ClientException')) {
          onConnectionFailure.call();
        } else {
          onException.call(exception);
        }
      },
    );
    onFinally?.call();
  }
}
