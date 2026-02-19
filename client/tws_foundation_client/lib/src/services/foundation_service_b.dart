import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Custom {abstract} class for [ServiceB] implementations.
///
///
/// Defines base behavior for [FoundationServiceB] implementations that are representations of requestable operations at a [ServerI] implementation.
abstract class FoundationServiceB extends ServiceBase {
  /// Creates a new [FoundationServiceB] instance.
  FoundationServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  ///
  Future<ResponseController> getSecure<T extends IEncodable>(
    String endpoint,
    String authToken, {
    Headers? headers,
  }) {
    return getSecure(
      endpoint,
      '$authToken@${ContextConstants.sign}',
      headers: headers,
    );
  }

  /// Post network call to connected server overriding [IService] built-in [post] behavior overriding
  /// the [authToken] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
  ///
  /// format: authToken@solutionSign
  ///
  ///
  /// [T] type of the request body.
  ///
  ///
  /// [endpoint] endpoint request last segment.
  ///
  /// [requestBody] data object to send at the [ServerI] to handle the request.
  ///
  /// [authToken] custom {TWS} authorization token when [ServerI] controller requires it.
  ///
  /// [headers] request scope [Headers] object.
  Future<ResponseController> postSecure<T extends IEncodable>(
    String endpoint,
    T requestBody, {
    String? authToken,
    Map<String, dynamic>? headers,
  }) {
    return postSecure(endpoint, requestBody, authToken: '$authToken@${ContextConstants.sign}');
  }

  /// Post network call to connected server overriding [IService] built-in [post] behavior overriding
  /// the [authToken] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
  ///
  /// format: authToken@solutionSign
  ///
  ///
  /// [T] type of the request body list.
  ///
  ///
  /// [action] endpoint request last segment.
  ///
  /// [requestBody] data object to send at the [ServerI] to handle the request.
  ///
  /// [authToken] custom {TWS} authorization token when [ServerI] controller requires it.
  ///
  /// [headers] request scope [Headers] object.
  Future<ResponseController> postListSecure<T extends IEncodable>(
    String endpoint,
    List<T> request, {
    String? authToken,
    Map<String, dynamic>? headers,
  }) {
    return postListSecure(endpoint, request, authToken: '$authToken@${ContextConstants.sign}', headers: headers);
  }
}
