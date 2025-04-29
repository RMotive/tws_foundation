import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/constants.dart';

/// Custom [CSMServiceBase] implementation for [TWS] business services base.
abstract class TWSServiceBase extends ServiceB {
  TWSServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Post network call to connected server overriding [CSMServiceBase] post behavior overriding
  /// the [auth] token sent to be able to send the [Solution] in the format the server requires:
  ///
  /// format: authToken@solutionSign
  Future<ResponseController> twsPost<T extends EncodableI>(
    String act,
    T request, {
    String? auth,
    Map<String, dynamic>? headers,
  }) {
    return post(act, request, auth: '$auth@${ContextConstants.sign}');
  }

  /// Post network call to connected server overriding [CSMServiceBase] post behavior overriding
  /// the [auth] token sent to be able to send the [Solution] in the format the server requires:
  ///
  /// format: authToken@solutionSign
  Future<ResponseController> twsPostList<T extends EncodableI>(
    String act,
    List<T> request, {
    String? auth,
    Map<String, dynamic>? headers,
  }) {
    return postList(act, request, auth: '$auth@${ContextConstants.sign}');
  }
}
