import 'dart:async';
import 'package:csm_view/csm_view.dart';

import 'package:example/core/landing_utils.dart';
import 'package:example/entries/auth_page_entry.dart';
import 'package:example/entries/category_layout_entry.dart';
import 'package:example/entries/entity_category_pages/trailers_inventory_category_page_entry.dart';
import 'package:example/entries/entity_category_pages/yardlogs_category_page_entry.dart';
import 'package:example/entries/entity_pages/accounts_page_entry.dart';
import 'package:example/entries/entity_pages/contacts_page_entry.dart';
import 'package:example/entries/entity_pages/drivers_page_entry.dart';
import 'package:example/entries/entity_pages/employees_page_entry.dart';
import 'package:example/entries/entity_pages/locations_page_entry.dart';
import 'package:example/entries/entity_pages/permits_page_entry.dart';
import 'package:example/entries/entity_pages/profiles_page_entry.dart';
import 'package:example/entries/entity_pages/sections_page_entry.dart';
import 'package:example/entries/entity_pages/solutions_page_entry.dart';
import 'package:example/entries/entity_pages/trailer_inventory_page_entry.dart';
import 'package:example/entries/entity_pages/trailers_page_entry.dart';
import 'package:example/entries/entity_pages/trucks_page_entry.dart';
import 'package:example/entries/entity_pages/yard_logs_page_entry.dart';
import 'package:example/entries/entity_tables/trailers_inventory_entity_table_entry.dart';
import 'package:example/entries/navigation_layout_entry.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


void main() {
  runApp(ViewPackageLanding());
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

              //! --> Entity Pages
              YardLogsPageEntry(),
              SectionsPageEntry(),
              EmployeesPageEntry(),
              DriversPageEntry(),
              TrucksPageEntry(),
              TrailersPageEntry(),
              LocationsPageEntry(),
              ContactsPageEntry(),
              PermitsPageEntry(),
              ProfilesPageEntry(),
              AccountsPageEntry(),
              SolutionsPageEntry(),
              TrailersInventoryPageEntry(),
              //! <-- Entity Pages

              //! --> Entity Category Pages
              // EmployeesCategoryPageEntry(),
              // YardLogsCategoryPageEntry(),
              // TrailersInventoryCategoryPageEntry(),
              // SectionsCategoryPageEntry(),
              // DriversCategoryPageEntry(),
              // TrucksCategoryPageEntry(),
              // TrailersCategoryPageEntry(),
              // LocationsCategoryPageEntry(),
              // ContactsCategoryPageEntry(),
              // PermitsCategoryPageEntry(),
              // ProfilesCategoryPageEntry(), 
              // AccountsCategoryPageEntry(),
              // SolutionsCategoryPageEntry(),
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
  FutureOr<void> initView(BuildContext context) async {
    messageLog('Initializing dependencies');
    final FoundationServer foundationServer = FoundationServer(kReleaseMode);

    InjectorUtils.addSingleton<FoundationServer>(foundationServer);
    InjectorUtils.addSingleton<SecurityServiceI>(foundationServer.securityService);
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

    final SessionStorage sessionStorage = SessionStorage();
    await sessionStorage.init();
    SessionData sessionData = await LandingUtils.authBuilder();

    sessionStorage.store(sessionData);

    InjectorUtils.addSingleton<SessionStorage>(sessionStorage);
    InjectorUtils.addSingleton<SessionStorageI>(sessionStorage);
      successLog(
        'Dependencies initialized',
        info: <String, Object?>{
          'isAuth': sessionStorage,
        },
      );
  }
  
  @override
  List<LandingThemeB> bootstrapTheming() {
    return <LandingThemeB>[
      LandingThemeDark(),
      LandingThemeLight(),
    ];
  }
}