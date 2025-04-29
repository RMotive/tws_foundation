import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Source that exposes the configured services dependencies for each
/// requirement, can be configured but if not, will use the default ones.
final class TWSFoundationSource extends ServerB {
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
    Headers? headers,
    ContactsServiceBase? contacts,
    Uri development = const Uri(
      '127.0.0.1',
      '',
      port: 5196,
      protocol: Protocols.http,
    ),
    Uri? production,
  }) : super(
          development,
          prodHost: production,
          httpClient: client,
          serverHeaders: headers,
        ) {
    this.solutions = solutions ?? SolutionsService(serverHost, client: client, headers: headers);
    this.accounts = accounts ?? AccountsService(serverHost, client: client);
    this.security = security ?? SecurityService(serverHost, client: client);
    this.contacts = contacts ?? ContactsService(serverHost, client: client);
  }
}
