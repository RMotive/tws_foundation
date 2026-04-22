import 'package:csm_view/csm_view.dart';

/// Defines the theme data base contract for {Foundation View} solution.
abstract class FoundationThemeB extends ThemeDataBase implements INavigationLayoutThemeData {
  //! --> [Asset]s access.

  /// Business main logo asset access.
  final String businessLogo;

  /// [CategoryLayout] ribbon buttons theme data.
  final StateControlTheming categoryLayoutRibbonButton;

  /// {controlWarning} scenarios theme data.
  final ThemingData controlWarning;

  /// [NavigationLayout] theme data.
  @override
  final ThemingData navigationLayout;

  //! <-- [Asset]s access
  
  /// Creates a new [FoundationThemeB] instance.
  const FoundationThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required super.control,
    required super.page,
    required super.dialog, 
    required super.controlError, 
    required super.controlSuccess, 
    required super.controlDisabled,
    required this.businessLogo,
    required this.navigationLayout,
    required this.categoryLayoutRibbonButton,
    required this.controlWarning,
  });
}
