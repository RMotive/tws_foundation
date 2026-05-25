import 'package:csm_view/csm_view.dart';

import 'package:example/core/landing_utils.dart';
import 'package:example/entries/auth_page_entry.dart';
import 'package:example/entries/category_layout_entry.dart';
import 'package:example/entries/entity_category_pages/employees_category_page_entry.dart';
import 'package:example/entries/entity_category_pages/solutions_category_page_entry.dart';
import 'package:example/entries/entity_category_pages/trailers_inventory_category_page_entry.dart';
import 'package:example/entries/navigation_layout_entry.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


class Logger with ConsoleMixin {}

void main() async {
  initDependencies();
  runApp(ViewPackageLanding());
}

void initDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();

    Logger logger = Logger();
    logger.messageLog('Initializing storage');

    final FoundationServer foundationServer = FoundationServer(kReleaseMode);
    InjectorUtils.addSingleton<FoundationServer>(foundationServer);
    InjectorUtils.addSingleton<SecurityServiceI>(foundationServer.securityService);
    
    final SessionStorage sessionStorage = SessionStorage();

    InjectorUtils.addSingleton<SessionStorage>(sessionStorage);
    InjectorUtils.addSingleton<SessionStorageI>(sessionStorage);
    
    await sessionStorage.init();

    SessionData sessionData = await LandingUtils.authBuilder();
    sessionStorage.store(sessionData);

    logger.messageLog('Initializing dependencies');

    InjectorUtils.addSingleton<YardLogsServiceI>(foundationServer.yardlogsService);
    InjectorUtils.addSingleton<LoadTypesServiceI>(foundationServer.loadtypeService);
    InjectorUtils.addSingleton<SolutionsServiceI>(foundationServer.solutionsService);
    InjectorUtils.addSingleton<EmployeesServiceI>(foundationServer.employeesService);
    InjectorUtils.addSingleton<DriversServiceI>(foundationServer.driversService);
    InjectorUtils.addSingleton<TrucksServiceI>(foundationServer.trucksService);
    InjectorUtils.addSingleton<SituationsServiceI>(foundationServer.situationsService);
    InjectorUtils.addSingleton<StatusesServiceI>(foundationServer.statusService);
    InjectorUtils.addSingleton<AccountServiceI>(foundationServer.accountService);
    InjectorUtils.addSingleton<LocationsServiceI>(foundationServer.locationsService);
    InjectorUtils.addSingleton<ManufacturersServiceI>(foundationServer.manufacturerService);
    InjectorUtils.addSingleton<VehiculeModelsServiceI>(foundationServer.vehiculeModelsService);
    InjectorUtils.addSingleton<CarriersServiceI>(foundationServer.carriersService);
    InjectorUtils.addSingleton<TrailersServiceI>(foundationServer.trailersService);
    InjectorUtils.addSingleton<TrailerTypesServiceI>(foundationServer.trailerTypesService);
    InjectorUtils.addSingleton<TrailerClassesServiceI>(foundationServer.trailerClassesService);
    InjectorUtils.addSingleton<SectionsServiceI>(foundationServer.sectionsService);
    InjectorUtils.addSingleton<ContactsServiceI>(foundationServer.contactService);
    InjectorUtils.addSingleton<PermitsServiceI>(foundationServer.permitsService);
    InjectorUtils.addSingleton<FeaturesServiceI>(foundationServer.featuresService);
    InjectorUtils.addSingleton<ActionsServiceI>(foundationServer.actionsService);
    InjectorUtils.addSingleton<ProfilesServiceI>(foundationServer.profilesService);
  
    logger.successLog(
      'Dependencies initialized',
      info: <String, Object?>{
        'isAuth': InjectorUtils.get<SessionStorage>(),
      },
    );
  }


final class ViewPackageLanding extends PackageLandingViewBase<LandingThemeB> with ConsoleMixin {
  /// Creates a new [ViewPackageLanding] instance.
  ViewPackageLanding({super.key}): super(
    name: "TWS Foundation View",
    description: (_, Color foreColor) {
      return TextSpan(
        text: 'This package provides a wide widget collection for UI implementations in TWS solutions.',
        style: TextStyle(
          color: foreColor,
          fontSize: 16,
        ),
      );
    },
    packageEntries: <IPackageLandingEntry<LandingThemeB>>[
              AuthPageEntry(),
              CategoryLayoutEntry(),
              NavigationLayoutEntry(
                appThemes: <LandingThemeB>[
                  LandingThemeDark(),
                  LandingThemeLight(),
                ],
              ),

              //! --> Category Layouts
              // SecurityCategoryLayoutEntry(),

              //! --> Entity Pages
              // YardLogsPageEntry(),
              // SectionsPageEntry(),
              // EmployeesPageEntry(),
              // DriversPageEntry(),
              // TrucksPageEntry(),
              // TrailersPageEntry(),
              // LocationsPageEntry(),
              // ContactsPageEntry(),
              // PermitsPageEntry(),
              // ProfilesPageEntry(),
              // AccountsPageEntry(),
              // SolutionsPageEntry(),
              // TrailersInventoryPageEntry(),
              //! <-- Entity Pages

              //! --> Entity Category Pages
              EmployeesCategoryPageEntry(),
              // YardLogsCategoryPageEntry(),
              TrailersInventoryCategoryPageEntry(),
              // SectionsCategoryPageEntry(),
              // DriversCategoryPageEntry(),
              // TrucksCategoryPageEntry(),
              // TrailersCategoryPageEntry(),
              // LocationsCategoryPageEntry(),
              // ContactsCategoryPageEntry(),
              // PermitsCategoryPageEntry(),
              // ProfilesCategoryPageEntry(), 
              // AccountsCategoryPageEntry(),
              SolutionsCategoryPageEntry(),
              //! <-- Entity Category Pages

              //! --> Foundation Entity Tables
              // YardLogsEntityTableEntry(),
              // SectionsEntityTableEntry(),
              // SolutionsEntityTableEntry(),
              // EmployeesEntityTableEntry(),
              // DriversEntityTableEntry(),
              // TrucksEntityTableEntry(),
              // TrailersEntityTableEntry(),
              // LocationsEntityTableEntry(),
              // ContactsEntityTableEntry(),
              // PermitsEntityTableEntry(),
              // ProfilesEntityTableEntry(),
              // AccountsEntityTableEntry(),
              // SolutionsEntityTableEntry(),
              // TrailerInventoryEntityTableEntry(),
              //! <-- Foundation Entity Tables
            ],
  );
  
  @override
  List<LandingThemeB> bootstrapTheming() {
    return <LandingThemeB>[
      LandingThemeDark(),
      LandingThemeLight(),
    ];
  }
}