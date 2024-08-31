import 'dart:convert';
import 'dart:typed_data';

import 'package:tws_foundation_client/src/core/constants/context_constants.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final Credentials qualityCredentials = Credentials(
  'twsm_quality',
  Uint8List.fromList(
    utf8.encode('twsmquality2024\$'),
  ),
  ContextConstants.sign,
);
