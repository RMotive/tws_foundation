import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class for [SecurityServiceB].
///
/// Defines a base behavior for [SecurityServiceI] implementations taht represents a {Security} operations
/// service operations provider from [FoundationServer].
abstract class SecurityServiceB extends FoundationServiceB implements SecurityServiceI {
  SecurityServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
