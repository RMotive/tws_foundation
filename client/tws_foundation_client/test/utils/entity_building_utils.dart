import 'dart:convert';
import 'dart:math';

import 'package:tws_foundation_client/src/services/security/solutions/solution.dart';

/// {utils} class for [EntityBuildingUtils].
final class EntityBuildingUtils {
  ///
  static String _randomString([int length = 12]) {
    final Random random = Random();
    final List<int> bytes = List<int>.generate(length, (int index) => random.nextInt(256));

    return base64UrlEncode(bytes).substring(0, length);
  }

  ///
  static Solution solution({
    String? name,
    String? description,
    String? sign,
  }) {
    final Solution entity = Solution();
    entity.name = name ?? _randomString(10);
    entity.description = description ?? _randomString();
    entity.sign = sign ?? _randomString(5);

    return entity;
  }
}
