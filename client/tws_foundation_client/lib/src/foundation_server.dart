import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/security/security/_security_service.dart';
import 'package:tws_foundation_client/src/services/security/solutions/_solutions_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for a [ServerB].
///
///
/// Defines the base behavior for a [FoundationServer] that handles the network address to communicate with a [FoundationServer] and its [ServiceI] implementations.
final class FoundationServer extends ServerB {
  /// {solution} security Entity service.
  late final SecurityServiceI securityService;

  /// [Solution] Entity service.
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

  /// [VehiculeModel] Entity service.
  late final VehiculeModelsServiceI vehiculeModelsService;

  /// [YardLog] Entity service.
  late final YardLogsServiceI yardlogsService;

  /// [DriverCommon] Entity Service.
  late final DriversServiceI driversService;

  /// [TruckCommon] Entity Service.
  late final TrucksServiceI trucksService;

  /// [Status] Entity Service.
  late final StatusesServiceI statusService;

  /// [Account] Entity Service.
  late final AccountServiceI accountService;

  /// [Trailer] Entity Service.
  late final TrailersServiceI trailersService;

  /// [Contact] Entity Service.
  late final ContactsServiceI contactService;

  /// [Permit] Entity Service.
  late final PermitsServiceI permitsService;

  /// [Feature] Entity Service.
  late final FeaturesServiceI featuresService;

  /// [Action] Entity Service.
  late final ActionsServiceI actionsService;

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
    ServiceImplementationBuilder<YardLogsServiceI>? yardlogsServiceBuilder,
    ServiceImplementationBuilder<DriversServiceI>? driversServiceBuilder,
    ServiceImplementationBuilder<TrucksServiceI>? trucksServiceBuilder,
    ServiceImplementationBuilder<StatusesServiceI>? statusServiceBuilder,
    ServiceImplementationBuilder<AccountServiceI>? accountServiceBuilder,
    ServiceImplementationBuilder<TrailersServiceI>? trailersServiceBuilder,
    ServiceImplementationBuilder<ContactsServiceI>? contactsServiceBuilder,
    ServiceImplementationBuilder<PermitsServiceI>? permitsServiceBuilder,
    ServiceImplementationBuilder<FeaturesServiceI>? featuresServiceBuilder,
    ServiceImplementationBuilder<ActionsServiceI>? actionsServiceBuilder,

  }) : super(
            isRelease: isRelease,
            devHost ??
                Uri(
                  'localhost',
                  '',
                  port: 5195,
                ),
            prodHost: prodHost) {
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
    driversService = driversServiceBuilder?.call(serverHost, httpClient) ?? DriversService(serverHost, client: httpClient);
    trucksService = trucksServiceBuilder?.call(serverHost, httpClient) ?? TruckService(serverHost, client: httpClient);
    statusService = statusServiceBuilder?.call(serverHost, httpClient) ?? StatusesService(serverHost, client: httpClient);
    accountService = accountServiceBuilder?.call(serverHost, httpClient) ?? AccountService(serverHost, client: httpClient);
    trailersService = trailersServiceBuilder?.call(serverHost, httpClient) ?? TrailersService(serverHost, client: httpClient);
    contactService = contactsServiceBuilder?.call(serverHost, httpClient) ?? ContactsService(serverHost, client: httpClient);
    permitsService = permitsServiceBuilder?.call(serverHost, httpClient) ?? PermitsService(serverHost, client: httpClient);
    featuresService = featuresServiceBuilder?.call(serverHost, httpClient) ?? FeaturesService(serverHost, client: httpClient);
    actionsService = actionsServiceBuilder?.call(serverHost, httpClient) ?? ActionsService(serverHost, client: httpClient);
  }
}
