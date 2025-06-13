import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/addresses/addresses_service_i.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carriers_service_i.dart';
import 'package:tws_foundation_client/src/services/business/employees/employees_service_i.dart';
import 'package:tws_foundation_client/src/services/business/load_types/load_types_service.dart';
import 'package:tws_foundation_client/src/services/business/load_types/load_types_service_i.dart';
import 'package:tws_foundation_client/src/services/business/locations/locations_service_i.dart';
import 'package:tws_foundation_client/src/services/business/manufacturers/manufacturers_service_i.dart';
import 'package:tws_foundation_client/src/services/business/sections/sections_service_i.dart';
import 'package:tws_foundation_client/src/services/business/situations/situations_service.dart';
import 'package:tws_foundation_client/src/services/business/situations/situatutions_service_i.dart';
import 'package:tws_foundation_client/src/services/business/trailer_classes/trailer_classes_service_i.dart';
import 'package:tws_foundation_client/src/services/business/trailer_types/trailer_types_service_i.dart';
import 'package:tws_foundation_client/src/services/business/vehicule_models/vehicule_models_service_i.dart';
import 'package:tws_foundation_client/src/services/security/security/_security_service.dart';
import 'package:tws_foundation_client/src/services/security/solutions/_solutions_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for a [ServerB].
///
///
/// Defines the base behavior for a [FoundationServer] that handles the network address to communicate with a [FoundationServer] and its [ServiceI] implementations.
final class FoundationServer extends ServerB {

  /// 
  late final SecurityServiceI securityService;

  ///
  late final SolutionsServiceI solutionsService;

  /// [Address] Entity service.
  late final AddressServiceI addressesService;

  /// [Carrier] Entity service.
  late final CarriersServiceI carriersService;

  /// [Employee] Entity service.
  late final EmployeesServiceI employeesService;

  /// [LoadType] Entity service.
  late final LoadTypesServiceI loadtypeService;

  /// [Location] Entity service.
  late final LocationsServiceI locationsService;

  /// [Manufacturer] Entity service.
  late final ManufacturersServiceI manufacturerService;
  
  /// [Section] Entity service.
  late final SectionsServiceI sectionsService;

  /// [Situation] Entity service.
  late final SituationsServiceI situationsService;

  /// [TrailerClass] Entity service.
  late final TrailerClassesServiceI trailerClassesService;

  /// [TrailerType] Entity service.
  late final TrailerTypesServiceI trailerTypesService;

  // [Truck] Entity service.
  // late final TrucksServiceI trucksService;

  /// [VehiculeModel] Entity service.
  late final VehiculeModelsServiceI vehiculeModelsService;

  /// [YardLog] Entity service.
  late final YardlogsServiceI yardlogsService;

  /// Creates a new [FoundationServer] instance.
  FoundationServer(
    bool isRelease, {
    Uri? devHost,
    Uri? prodHost,
    ServiceImplementationBuilder<SecurityServiceI>? securityServiceBuilder,
    ServiceImplementationBuilder<SolutionsServiceI>? solutionsServiceBuilder,
    ServiceImplementationBuilder<AddressServiceI>? addressesServiceBuilder,
    ServiceImplementationBuilder<CarriersServiceI>? carriersServiceBuilder,
    ServiceImplementationBuilder<EmployeesServiceI>? employeesServiceBuilder,
    ServiceImplementationBuilder<LoadTypesServiceI>? loadtypesServiceBuilder,
    ServiceImplementationBuilder<LocationsServiceI>? locationsServiceBuilder,
    ServiceImplementationBuilder<ManufacturersServiceI>? manufacturersServiceBuilder,
    ServiceImplementationBuilder<SectionsServiceI>? sectionsServiceBuilder,
    ServiceImplementationBuilder<SituationsServiceI>? situationsServiceBuilder,
    ServiceImplementationBuilder<TrailerClassesServiceI>? trailerClassesServiceBuilder,
    ServiceImplementationBuilder<TrailerTypesServiceI>? trailerTypesServiceBuilder,
    ServiceImplementationBuilder<VehiculeModelsServiceI>? vehiculemodelsServiceBuilder,
    ServiceImplementationBuilder<YardlogsServiceI>? yardlogsServiceBuilder,
  })
      : super(
          isRelease: isRelease,
            devHost ??
                Uri(
            'localhost',
            '',
            port: 5195,
          ),
            prodHost: prodHost
        ) {


    securityService = securityServiceBuilder?.call(serverHost, httpClient) ?? SecurityService(serverHost, client: httpClient);
    solutionsService = solutionsServiceBuilder?.call(serverHost, httpClient) ?? SolutionsService(serverHost, client: httpClient);
    addressesService = addressesServiceBuilder?.call(serverHost, httpClient) ?? AddressesService(serverHost, client: httpClient);
    carriersService = carriersServiceBuilder?.call(serverHost, httpClient) ?? CarrieresService(serverHost, client: httpClient);
    employeesService = employeesServiceBuilder?.call(serverHost, httpClient) ?? EmployeesService(serverHost, client: httpClient);
    loadtypeService = loadtypesServiceBuilder?.call(serverHost, httpClient) ?? LoadTypesService(serverHost, client: httpClient);
    locationsService = locationsServiceBuilder?.call(serverHost, httpClient) ?? LocationsService(serverHost, client: httpClient);
    manufacturerService = manufacturersServiceBuilder?.call(serverHost, httpClient) ?? ManufacturerService(serverHost, client: httpClient);
    sectionsService = sectionsServiceBuilder?.call(serverHost, httpClient) ?? SectionsService(serverHost, client: httpClient);
    situationsService = situationsServiceBuilder?.call(serverHost, httpClient) ?? SituationsService(serverHost, client: httpClient);
    trailerClassesService = trailerClassesServiceBuilder?.call(serverHost, httpClient) ?? TrailerClassesService(serverHost, client: httpClient);
    trailerTypesService = trailerTypesServiceBuilder?.call(serverHost, httpClient) ?? TrailerTypesService(serverHost, client: httpClient);
    vehiculeModelsService = vehiculemodelsServiceBuilder?.call(serverHost, httpClient) ?? VehiculeModelService(serverHost, client: httpClient);
    yardlogsService = yardlogsServiceBuilder?.call(serverHost, httpClient) ?? YardLogsService(serverHost, client: httpClient);

  }
}
