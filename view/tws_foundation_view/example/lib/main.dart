import 'dart:async';

import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/core/landing_utils.dart';
import 'package:example/entries/category_layout_entry.dart';
import 'package:example/entries/entity_category_pages/employees_category_page_entry.dart';
import 'package:example/entries/entity_category_pages/yardlogs_category_page_entry.dart';
import 'package:example/entries/entity_pages/employees_page_entry.dart';
import 'package:example/entries/entity_tables/employees_entity_table_entry.dart';
import 'package:example/entries/navigation_layout_entry.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' hide NavigationLayoutEntry;

const Console _console = Console('Foundation View');

void main() {
  runApp(const MainApp());
}

final class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

final class _MainAppState extends State<MainApp> {
  ///
  Future<void> initDependencies() async {
    _console.message('Initializing dependencies');
    final FoundationServer foundationServer = FoundationServer(kReleaseMode);

    Injector.addSingleton<FoundationServer>(foundationServer);
    Injector.addSingleton<SecurityServiceI>(foundationServer.securityService);
    Injector.addSingleton<YardLogsServiceI>(foundationServer.yardlogsService);
    Injector.addSingleton<LoadTypesServiceI>(foundationServer.loadtypeService);
    Injector.addSingleton<SolutionsServiceI>(foundationServer.solutionsService);
    Injector.addSingleton<EmployeesServiceI>(foundationServer.employeesService);
    Injector.addSingleton<DriversServiceI>(foundationServer.driversService);
    Injector.addSingleton<TrucksServiceI>(foundationServer.trucksService);
    Injector.addSingleton<SituationsServiceI>(foundationServer.situationsService);
    Injector.addSingleton<StatusesServiceI>(foundationServer.statusService);
    Injector.addSingleton<AccountServiceI>(foundationServer.accountService);
    Injector.addSingleton<LocationsServiceI>(foundationServer.locationsService);
    Injector.addSingleton<ManufacturersServiceI>(foundationServer.manufacturerService);
    Injector.addSingleton<VehiculeModelsServiceI>(foundationServer.vehiculeModelsService);
    Injector.addSingleton<CarriersServiceI>(foundationServer.carriersService);
    Injector.addSingleton<TrailersServiceI>(foundationServer.trailersService);
    Injector.addSingleton<TrailerTypesServiceI>(foundationServer.trailerTypesService);
    Injector.addSingleton<TrailerClassesServiceI>(foundationServer.trailerClassesService);
    Injector.addSingleton<SectionsServiceI>(foundationServer.sectionsService);
    Injector.addSingleton<ContactsServiceI>(foundationServer.contactService);
    Injector.addSingleton<PermitsServiceI>(foundationServer.permitsService);
    Injector.addSingleton<FeaturesServiceI>(foundationServer.featuresService);
    Injector.addSingleton<ActionsServiceI>(foundationServer.actionsService);
    Injector.addSingleton<ProfilesServiceI>(foundationServer.profilesService);

    final SessionStorage sessionStorage = SessionStorage();
    await sessionStorage.init();
    SessionData sessionData = await LandingUtils.authBuilder();

    sessionStorage.store(sessionData);

    Injector.addSingleton<SessionStorage>(sessionStorage);
    Injector.addSingleton<SessionStorageI>(sessionStorage);
    _console.success(
      'Dependencies initialized',
      info: <String, Object?>{
        'isAuth': sessionStorage,
      },
    );
  }

  late Future<void> _initInv = initDependencies();

  bool hasError = false;

  @override
  void didUpdateWidget(covariant MainApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (hasError) {
      hasError = false;
      _initInv = initDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<LandingThemeB> themes = <LandingThemeB>[
      LandingThemeDark(),
      LandingThemeLight(),
    ];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AsyncWidget<void>(
        isVoid: true,
        future: _initInv,
        errorBuilder: (BuildContext ctx, Object? error, void data) {
          hasError = true;
          return ErrorWidget(error ?? 'Unknown error');
        },
        successBuilder: (BuildContext ctx, void data) {
          return PackageLanding<LandingThemeB>(
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
            defaultTheme: LandingThemeDark(),
            themes: themes,
            landingEntries: <PackageLandingEntryI<LandingThemeB>>[
              // AuthPageEntry(),
              CategoryLayoutEntry(),
              NavigationLayoutEntry(
                appThemes: themes,
              ),

              //! --> Entity Pages
              // YardLogsPageEntry(),
              // SectionsPageEntry(),
              EmployeesPageEntry(),
              // // DriversPageEntry(),
              // // TrucksPageEntry(),
              // // TrailersPageEntry(),
              // LocationsPageEntry(),
              // ContactsPageEntry(),
              // PermitsPageEntry(),
              // ProfilesPageEntry(),
              // AccountsPageEntry(),
              // SolutionsPageEntry(),
              //! <-- Entity Pages

              //! --> Entity Category Pages
              EmployeesCategoryPageEntry(),
              YardLogsCategoryPageEntry(),
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
              // // SolutionsEntityTableEntry(),
              EmployeesEntityTableEntry(),
              // DriversEntityTableEntry(),
              // // TrucksEntityTableEntry(),
              // TrailersEntityTableEntry(),
              // LocationsEntityTableEntry(),
              // ContactsEntityTableEntry(),
              // PermitsEntityTableEntry(),
              // ProfilesEntityTableEntry(),
              //AccountsEntityTableEntry(),
              // SolutionsEntityTableEntry(),
              //! <-- Foundation Entity Tables
            ],
          );
        },
      ),
    );
  }
}
