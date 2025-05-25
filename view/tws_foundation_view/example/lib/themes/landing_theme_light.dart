import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class LandingThemeLight extends PackageLandingThemeDark
    implements LandingThemeB {
  final FoundationThemeLight _foundation = FoundationThemeLight();

  ///
  LandingThemeLight();
  
  @override
  StateTheming get articlesLayoutActionButtonState =>
      _foundation.articlesLayoutActionButtonState;

  @override
  StateTheming get articlesLayoutSelectorButtonState =>
      _foundation.articlesLayoutSelectorButtonState;

  @override
  String get authPageBusinessLogoAssetAccess =>
      _foundation.authPageBusinessLogoAssetAccess;

  @override
  StateTheming get criticalControlState => _foundation.criticalControlState;

  @override
  SimpleTheming get masterLayout => _foundation.masterLayout;

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
