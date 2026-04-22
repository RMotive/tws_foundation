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
  ThemingData get page => _foundation.page;
  
  @override
  String get businessLogo => _foundation.businessLogo;

  @override
  ThemingData get controlError => _foundation.controlError;

  @override
  ThemingData get controlWarning => _foundation.controlWarning;

  @override
  ThemingData get controlSuccess => _foundation.controlSuccess;

  @override
  ThemingData get control => _foundation.control;

  @override
  ThemingData get controlDisabled => _foundation.controlDisabled;

  @override
  ThemingData get navigationLayout => _foundation.navigationLayout;

  @override
  StateControlTheming get categoryLayoutRibbonActionButton => _foundation.categoryLayoutRibbonActionButton;
}
  