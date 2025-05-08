import 'dart:convert';

import 'package:csm_client/csm_client.dart';

/// (testing) {utilities} class implementation for [TestUtils].
///
/// Defines utilities methods for testing purposes.
final class TestUtils {
  ///
  static DataMap createSuccessFrameDataMap(DataMap estela) {
    return <String, Object?>{
      'tracer': 'test_tracer',
      'estela': estela,
    };
  }

  /// Creates a [MockClient] instance object for {definition} purposes tests, overriding the actual [Client] that makes network request to the actual server.
  ///
  /// [endpointMocks] a [Map] object that stores the endpoint [String] identification and the overriden [T] object to force as a response inside a [SuccessFrame].
  static MockClient createMockClient<T extends EncodableI>(Map<String, T> endpointMocks) {
    final MockClient mockClient = MockClient(
      (Request request) async {
        final String endpointSegment = request.url.pathSegments.last;

        if (endpointMocks.containsKey(endpointSegment)) {
          T estela = endpointMocks[endpointSegment]!;
          DataMap dataMap = createSuccessFrameDataMap(estela.encode());

          return Response(jsonEncode(dataMap), 200);
        }

        return Response('', 404);
      },
    );

    return mockClient;
  }
}
