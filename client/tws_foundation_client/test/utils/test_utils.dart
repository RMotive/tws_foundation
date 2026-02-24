
import 'package:csm_client_core/csm_client_core.dart';

/// (testing) {utilities} class implementation for [TestingClientUtils].
///
/// Defines utilities methods for testing purposes.
final class TestingClientUtils {
  ///
  static DataMap createSuccessFrameDataMap(DataMap content) {
    return <String, Object?>{
      'id': 'test_tracer',
      'content': content,
    };
  }
}
