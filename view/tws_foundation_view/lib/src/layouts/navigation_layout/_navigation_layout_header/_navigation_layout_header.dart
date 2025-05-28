part of '../navigation_layout.dart';

///
final class _MasterLayoutHeader extends StatelessWidget {
  ///
  final List<ThemeI> appThemes;

  ///
  final Route? rootRoute;

  /// Creates a new [_MasterLayoutHeader] instance.
  const _MasterLayoutHeader({
    required this.appThemes,
    this.rootRoute,
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
                    onTap: () {},
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
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ThemeSwitcher(
                        applicationThemes: appThemes,
                      ),
                    ),

                  _NavigationHeaderUserButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
