import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
abstract class LandingThemeB extends PackageLandingThemeBase
    implements FoundationThemeB {
  ///
  LandingThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required super.page,
    required super.landingHeader,
    required super.welcomeCardTheming,
    required super.control,
    required super.controlError,
    required super.controlSuccess,
    required super.controlDisabled,
    required super.dialog,
  });
}
