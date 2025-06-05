import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
abstract class LandingThemeB extends PackageLandingThemeB
    implements FoundationThemeB {
  ///
  LandingThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required super.pageTheming,
    required super.headerTheming,
    required super.welcomeCardTheming,
  });
}
