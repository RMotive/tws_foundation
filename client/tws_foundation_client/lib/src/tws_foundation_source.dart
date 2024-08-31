import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/services/account_service.dart';
import 'package:tws_foundation_client/src/services/bases/accounts_service_base.dart';
import 'package:tws_foundation_client/src/services/drivers_externals_service.dart';
import 'package:tws_foundation_client/src/services/drivers_service.dart';
import 'package:tws_foundation_client/src/services/load_type_service.dart';
import 'package:tws_foundation_client/src/services/manufacturers_service.dart';
import 'package:tws_foundation_client/src/services/sections_service.dart';
import 'package:tws_foundation_client/src/services/security_service.dart';
import 'package:tws_foundation_client/src/services/situations_service.dart';
import 'package:tws_foundation_client/src/services/solutions_service.dart';
import 'package:tws_foundation_client/src/services/trailer_service.dart';
import 'package:tws_foundation_client/src/services/trailers_externals_service.dart';
import 'package:tws_foundation_client/src/services/trucks_externals_service.dart';
import 'package:tws_foundation_client/src/services/trucks_service.dart';
import 'package:tws_foundation_client/src/services/yard_log_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Source that exposes the configured services dependencies for each
/// requirement, can be configured but if not, will use the default ones.
final class TWSFoundationSource extends CSMSourceBase {
  // --> Services

  /// Solutions service.
  late final SolutionsServiceBase solutions;
  /// Accounts service.
  late final AccountsServiceBase accounts;
  /// Security service.
  late final SecurityServiceBase security;
  /// Trucks Service.
  late final TrucksServiceBase trucks;
  // Manufacturers Service.
  late final ManufacturersServiceBase manufacturers;
  // Situations Service.
  late final SituationsServiceBase situations;
  // External drivers service
  late final DriversExternalsServiceBase driversExternals;
  // Drivers service
  late final DriversServiceBase drivers;
  // Externals trailers service
  late final TrailersExternalsServiceBase trailersExternals;
  // Trailers service
  late final TrailersServiceBase trailers;
  // External trucks service
  late final TrucksExternalsServiceBase trucksExternals;
  // Loads type service
  late final LoadTypeServiceBase loadTypes;
  // Sections service
  late final SectionsServiceBase sections;
  // Yard log service
  late final YardLogServiceBase yardLogs;

  /// Generates a new data source building its internal
  /// services.
  TWSFoundationSource(
    bool debug, {
    Client? client,
    SolutionsServiceBase? solutions,
    AccountsServiceBase? accounts,
    SecurityServiceBase? security,
    CSMHeaders? headers,
    TrucksServiceBase? trucks,
    ManufacturersServiceBase? manufacturers,
    SituationsServiceBase? situations,
    DriversExternalsService? driversExternals,
    DriversService? drivers,
    TrailersExternalsService? trailersExternals,
    TrailersService? trailers,
    TrucksExternalsService? trucksExternals,
    LoadTypeService? loadTypes,
    SectionsService? sections,
    YardLogsService? yardLogs,
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
    this.accounts = accounts ?? AccountService(host, client: client);
    this.security = security ?? SecurityService(host, client: client);
    this.trucks = trucks ?? TrucksService(host, client: client);
    this.manufacturers = manufacturers ?? ManufacturersService(host, client: client);
    this.situations = situations ?? SituationsService(host, client: client);
    this.driversExternals = driversExternals ?? DriversExternalsService(host, client: client);
    this.drivers = drivers ?? DriversService(host, client: client);
    this.trailersExternals = trailersExternals ?? TrailersExternalsService(host, client: client);
    this.trailers = trailers ?? TrailersService(host, client: client);
    this.trucksExternals = trucksExternals ?? TrucksExternalsService(host, client: client);
    this.loadTypes = loadTypes ?? LoadTypeService(host, client: client);
    this.sections = sections ?? SectionsService(host, client: client);
    this.yardLogs = yardLogs ?? YardLogsService(host, client: client);

  }
}
