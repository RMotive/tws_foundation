import 'package:csm_view/csm_view.dart' hide LandingThemeB; 
import 'package:example/entries/auth_page_entry.dart';
import 'package:example/entries/category_layout_entry.dart';
import 'package:example/entries/entity_category_pages/employees_category_page_entry.dart';
import 'package:example/entries/entity_pages/employees_page_entry.dart';
import 'package:example/entries/entity_pages/yard_logs_page_entry.dart';
import 'package:example/entries/entity_tables/employees_entity_table_entry.dart';
import 'package:example/entries/entity_tables/solutions_entity_table_entry.dart';
import 'package:example/entries/entity_tables/yardlogs_entity_table_entry.dart';
import 'package:example/entries/navigation_layout_entry.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  runApp(const MainApp());
}

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LandingThemeB> themes = <LandingThemeB>[
      LandingThemeDark(),
      LandingThemeLight(),
    ];

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
      onInit: () {
        final FoundationServer foundationServer = FoundationServer(kReleaseMode);

        Injector.addSingleton<FoundationServer>(foundationServer);
        Injector.addSingleton<SecurityServiceI>(foundationServer.securityService);
        Injector.addSingleton<YardlogsServiceI>(foundationServer.yardlogsService);
        Injector.addSingleton<SolutionsServiceI>(foundationServer.solutionsService);
        Injector.addSingleton<EmployeesServiceI>(foundationServer.employeesService);
      },
      defaultTheme: LandingThemeDark(),
      themes: themes,
      landingEntries: <PackageLandingEntryI<LandingThemeB>>[
        AuthPageEntry(),
        CategoryLayoutEntry(),
        NavigationLayoutEntry(
          appThemes: themes,
        ),
        
        //! --> Entity Pages
        YardLogsPageEntry(),
        EmployeesPageEntry(),

        //! <-- Entity Pages

        //! --> Entity Category Pages
        EmployeesCategoryPageEntry(),

        //! <-- Entity Category Pages

        //! --> Foundation Entity Tables 

        YardLogsEntityTableEntry(),
        SolutionsEntityTableEntry(),
        EmployeesEntityTableEntry(),

        //! <-- Foundation Entity Tables
      ],
    );
  }
}
