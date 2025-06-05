part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws the [NavigationLayout] header.
final class _NavigationLayoutHeader extends StatelessWidget {
  /// Default root [Route], used to draw and handle a Home button that directs to this [Route].
  final Route? rootRoute;

  /// Application [ThemeI] collection.
  final List<ThemeI> appThemes;

  /// User information, used to draw an User Button to access information and options.
  final NavigationLayoutHeaderUserI? user;

  /// {internal} Reactor reference for [_NavigationLayoutNavigation] state.
  final _NavigationLayourNavigationReactor navReactor;

  /// Creates a new [_NavigationLayoutHeader] instance.
  const _NavigationLayoutHeader({
    this.user,
    this.rootRoute,
    required this.appThemes,
    required this.navReactor,
  });

  @override
  Widget build(BuildContext context) {
    final SimpleTheming theme = Theming.get<FoundationThemeB>().navigationLayout;
    final Router router = Injector.get();

    return ColoredBox(
      color: theme.back,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// --> Navigation Header Menu Drawer Toogle Button
              Visibility(
                visible: true,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: navReactor.toogle,
                    child: Icon(
                      Icons.menu,
                      color: theme.fore,
                    ),
                  ),
                ),
              ),

              /// --> Navigation Header Theme Selection
              Row(
                children: <Widget>[
                  if (rootRoute != null)
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: theme.fore,
                      ),
                      onPressed: () {
                        router.go(rootRoute!);
                      },
                    ),

                  if (appThemes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: ThemeSwitcher(
                        applicationThemes: appThemes,
                      ),
                    ),

                  if (user != null)
                    _NavigationHeaderUserButton(
                      user: user!,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
