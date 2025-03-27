import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Source that exposes the configured services dependencies for each
/// requirement, can be configured but if not, will use the default ones.
final class TWSFoundationSource extends CSMSourceBase {
  /// --> Services

  /// Solutions service.
  late final SolutionsServiceBase solutions;

  /// Accounts service.
  late final AccountsServiceBase accounts;

  /// Security service.
  late final SecurityServiceBase security;

  /// Contact service
  late final ContactsServiceBase contacts;

  /// [TWSFoundationSource] instance constructor.
  ///
  /// [debug] wheter the current execution context is debugging.
  ///
  /// [client] custom network [Client] for testing/quality purposes.
  ///
  /// [development] development server address.
  ///
  /// [production] production server address.
  ///
  ///
  /// Each service implementation can be overriden for a custom one.
  TWSFoundationSource(
    bool debug, {
    Client? client,
    SolutionsServiceBase? solutions,
    AccountsServiceBase? accounts,
    SecurityServiceBase? security,
    CSMHeaders? headers,
    ContactsServiceBase? contacts,
    CSMUri development = const CSMUri(
      '127.0.0.1',
      '',
      port: 5196,
      protocol: CSMProtocols.http,
    ),
    CSMUri? production,
  }) : super(
          debug,
          development,
          production: production,
          headers: headers,
        ) {
    this.solutions = solutions ?? SolutionsService(host, client: client, headers: this.headers);
    this.accounts = accounts ?? AccountsService(host, client: client);
    this.security = security ?? SecurityService(host, client: client);
    this.contacts = contacts ?? ContactsService(host, client: client);
  }
}
