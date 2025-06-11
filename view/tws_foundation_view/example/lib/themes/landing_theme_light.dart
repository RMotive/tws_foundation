import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class LandingThemeLight extends PackageLandingThemeLight
    implements LandingThemeB {
  final FoundationThemeLight _foundation = FoundationThemeLight();

  ///
  LandingThemeLight();

  @override
  SimpleTheming get page => _foundation.page;
  
  @override
  String get businessLogo => _foundation.businessLogo;

  @override
  SimpleTheming get errorTheming => _foundation.errorTheming;

  @override
  SimpleTheming get warnTheming => _foundation.warnTheming;

  @override
  SimpleTheming get succTheming => _foundation.succTheming;

  @override
  SimpleTheming get primControl => _foundation.primControl;

  @override
  SimpleTheming get navigationLayout => _foundation.navigationLayout;
  @override
  EntityTableTheming get entityTableTheming => _foundation.entityTableTheming;

  @override
  StateTheming get categoryLayoutRibbonButton => _foundation.categoryLayoutRibbonButton;
}
