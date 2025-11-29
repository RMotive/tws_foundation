part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws the [NavigationLayout] header.
final class _NavigationLayoutHeader extends StatelessWidget {
  /// Default root [Route], used to draw and handle a Home button that directs to this [Route].
  final Route? rootRoute;

  /// User information, used to draw an User Button to access information and options.
  final NavigationLayoutHeaderUserI? user;

  /// {internal} Reactor reference for [_NavigationLayoutNavigation] state.
  final _NavigationLayourNavigationReactor navReactor;

  /// Header application logo.
  final ImageProvider? logo;
  

  /// Creates a new [_NavigationLayoutHeader] instance.
  const _NavigationLayoutHeader({
    this.user,
    this.rootRoute,
    this.logo,
    required this.navReactor,
  });

  @override
  Widget build(BuildContext context) {
    final SimpleTheming theme = Theming.get<FoundationThemeB>(context).navigationLayout;
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
              /// --> Header left section
              Row(
                spacing: 30,
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

                  /// --> App Logo
                  if(logo != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:  4.0),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image(image: logo!),
                    ),
                  )
                ],
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
                    
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: ThemeSwitcher(),
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
