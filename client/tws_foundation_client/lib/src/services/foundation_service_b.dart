import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';

/// Custom {abstract} class for [ServiceB] implementations.
///
///
/// Defines base behavior for [FoundationServiceB] implementations that are representations of requestable operations at a [ServerI] implementation.
abstract class FoundationServiceB extends ServiceB {
  /// Creates a new [FoundationServiceB] instance.
  FoundationServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Post network call to connected server overriding [ServiceI] built-in [post] behavior overriding
  /// the [authToken] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
  ///
  /// format: authToken@solutionSign
  ///
  ///
  /// [T] type of the request body.
  ///
  ///
  /// [action] endpoint request last segment.
  ///
  /// [requestBody] data object to send at the [ServerI] to handle the request.
  ///
  /// [authToken] custom {TWS} authorization token when [ServerI] controller requires it.
  ///
  /// [headers] request scope [Headers] object.
  Future<ResponseController> postSecure<T extends EncodableI>(
    String action,
    T requestBody, {
    String? authToken,
    Map<String, dynamic>? headers,
  }) {
    return post(action, requestBody, auth: '$authToken@${ContextConstants.sign}');
  }

  /// Post network call to connected server overriding [ServiceI] built-in [post] behavior overriding
  /// the [auth] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
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
  Future<ResponseController> postListSecure<T extends EncodableI>(
    String act,
    List<T> request, {
    String? auth,
    Map<String, dynamic>? headers,
  }) {
    return postList(act, request, auth: '$auth@${ContextConstants.sign}');
  }
}
