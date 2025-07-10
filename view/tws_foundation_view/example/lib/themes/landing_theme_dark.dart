import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class LandingThemeDark extends PackageLandingThemeDark
    implements LandingThemeB {
  ///
  LandingThemeDark();

  final FoundationThemeDark _foundation = FoundationThemeDark();


  @override
  SimpleTheming get page => _foundation.page;
  
  @override
  String get businessLogo => _foundation.businessLogo;

  @override
  SimpleTheming get error => _foundation.error;

  @override
  SimpleTheming get navigationLayout => _foundation.navigationLayout;

  @override
  SimpleTheming get warning => _foundation.warning;

  @override
  SimpleTheming get success => _foundation.success;

  @override
  SimpleTheming get control => _foundation.control;

  @override
  EntityTableTheming get entityTable => _foundation.entityTable;

  @override
  StateTheming get categoryLayoutRibbonButton => _foundation.categoryLayoutRibbonButton;
}
