import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [YardLog] entity service base
abstract class YardLogsServiceB extends FoundationServiceB implements YardlogsServiceI {
  /// Creates a new [YardLogsServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  YardLogsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
