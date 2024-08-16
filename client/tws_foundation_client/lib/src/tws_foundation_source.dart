import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/services/manufacturers_service.dart';
import 'package:tws_foundation_client/src/services/security_service.dart';
import 'package:tws_foundation_client/src/services/situations_service.dart';
import 'package:tws_foundation_client/src/services/solutions_service.dart';
import 'package:tws_foundation_client/src/services/trucks_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Source that exposes the configured services dependencies for each
/// requirement, can be configured but if not, will use the default ones.
final class TWSAdministrationSource extends CSMSourceBase {
  // --> Services

  /// Solutions service.
  late final SolutionsServiceBase solutions;

  /// Security service.
  late final SecurityServiceBase security;

  /// Trucks Service.
  late final TrucksServiceBase trucks;
  // Manufacturers Service.
  late final ManufacturersServiceBase manufacturers;
  // Situations Service.
  late final SituationsServiceBase situations;

  /// Generates a new data source building its internal
  /// services.
  TWSAdministrationSource(
    bool debug, {
    Client? client,
    SolutionsServiceBase? solutions,
    SecurityServiceBase? security,
    CSMHeaders? headers,
    TrucksServiceBase? trucks,
    ManufacturersServiceBase? manufacturers,
    SituationsServiceBase? situations,
    CSMUri development = const CSMUri(
      '192.168.100.32',
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
    this.security = security ?? SecurityService(host, client: client);
    this.trucks = trucks ?? TrucksService(host, client: client);
    this.manufacturers = manufacturers ?? ManufacturersService(host, client: client);
    this.situations = situations ?? SituationsService(host, client: client);
  }
}
