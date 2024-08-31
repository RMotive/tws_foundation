import 'dart:convert';
import 'dart:typed_data';

import 'package:dotenv/dotenv.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final DotEnv _env = DotEnv()..load();

final Credentials testCredentials = Credentials(
  _env['identity']!,
  Uint8List.fromList(
    utf8.encode(_env['password']!),
  ),
  _env['sign']!,
);
