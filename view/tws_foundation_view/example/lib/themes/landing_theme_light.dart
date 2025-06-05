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
  StateTheming get categoryLayoutRibbonButton => _foundation.categoryLayoutRibbonButton;

  @override
  String get businessLogo => _foundation.businessLogo;

  @override
  StateTheming get criticalControlState => _foundation.criticalControlState;

  @override
  SimpleTheming get navigationLayout => _foundation.navigationLayout;

  @override
  StateTheming get masterLayoutMenuButtonState =>
      _foundation.masterLayoutMenuButtonState;

  @override
  SimpleTheming get page => _foundation.page;

  @override
  SimpleTheming get primaryControlColor => _foundation.primaryControlColor;

  @override
  StateTheming get primaryControlState => _foundation.primaryControlState;

  @override
  SimpleTheming get primaryCriticalControl =>
      _foundation.primaryCriticalControl;

  @override
  SimpleTheming get primaryDisabledControl =>
      _foundation.primaryDisabledControl;
}
