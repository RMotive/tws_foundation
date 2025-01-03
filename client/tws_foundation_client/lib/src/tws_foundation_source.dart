import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/carriers_service.dart';
import 'package:tws_foundation_client/src/services/business/drivers_externals_service.dart';
import 'package:tws_foundation_client/src/services/business/drivers_service.dart';
import 'package:tws_foundation_client/src/services/business/employee_service.dart';
import 'package:tws_foundation_client/src/services/business/load_type_service.dart';
import 'package:tws_foundation_client/src/services/business/locations_service.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers_service.dart';
import 'package:tws_foundation_client/src/services/business/sections_service.dart';
import 'package:tws_foundation_client/src/services/business/situations_service.dart';
import 'package:tws_foundation_client/src/services/business/trailer_service.dart';
import 'package:tws_foundation_client/src/services/business/trailers_classes_service.dart';
import 'package:tws_foundation_client/src/services/business/trailers_externals_service.dart';
import 'package:tws_foundation_client/src/services/business/trailers_types_service.dart';
import 'package:tws_foundation_client/src/services/business/trucks_externals_service.dart';
import 'package:tws_foundation_client/src/services/business/trucks_inventories_service.dart';
import 'package:tws_foundation_client/src/services/business/trucks_service.dart';
import 'package:tws_foundation_client/src/services/business/vehicules_models_service.dart';
import 'package:tws_foundation_client/src/services/business/yard_log_service.dart';
import 'package:tws_foundation_client/src/services/security/account_service.dart';
import 'package:tws_foundation_client/src/services/security/contacts_service.dart';
import 'package:tws_foundation_client/src/services/security/security_service.dart';
import 'package:tws_foundation_client/src/services/security/solutions_service.dart';
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

  /// Trucks Service.
  late final TrucksServiceBase trucks;

  /// Manufacturers Service.
  late final ManufacturersServiceBase manufacturers;

  /// Situations Service.
  late final SituationsServiceBase situations;

  /// External drivers service
  late final DriversExternalsServiceBase driversExternals;

  /// Drivers service
  late final DriversServiceBase drivers;

  /// Externals trailers service
  late final TrailersExternalsServiceBase trailersExternals;

  /// Trailers service
  late final TrailersServiceBase trailers;

  /// External trucks service
  late final TrucksExternalsServiceBase trucksExternals;

  /// Loads type service
  late final LoadTypeServiceBase loadTypes;

  /// Sections service
  late final SectionsServiceBase sections;

  /// Yard log service
  late final YardLogServiceBase yardLogs;

  /// Carriers Service
  late final CarriersServiceBase carriers;

  /// Vehicules models service
  late final VehiculesModelsServiceBase vehiculesModels;

  /// Truck Inventory service
  late final TrucksInventoriesServiceBase trucksInventories;

  // Trailer Type models service
  late final TrailersTypesServiceBase trailersTypes;
  
  // Trailer Class service
  late final TrailersClassesServiceBase trailersClasses;

  /// Contact service
  late final ContactsServiceBase contacts;

  /// Employees service
  late final EmployeeService employees;

  /// Locations service
  late final LocationsService locations;

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
    CarriersService? carriers,
    VehiculesModelsService? vehiculesModels,
    TrucksInventoriesService? trucksInventories,
    TrailersTypesService? trailersTypes,
    TrailersClassesService? trailersClasses,
    ContactsService? contacts,
    EmployeeService? employees,
    LocationsService? locations,

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
    this.carriers = carriers ?? CarriersService(host, client: client);
    this.vehiculesModels = vehiculesModels ?? VehiculesModelsService(host, client: client);
    this.trucksInventories = trucksInventories ?? TrucksInventoriesService(host, client: client);
    this.trailersTypes = trailersTypes ?? TrailersTypesService(host, client: client);
    this.trailersClasses = trailersClasses ?? TrailersClassesService(host, client: client);    
    this.contacts = contacts ?? ContactsService(host, client: client);
    this.employees = employees ?? EmployeeService(host, client: client);
    this.locations = locations ?? LocationsService(host, client: client);

  }
}
