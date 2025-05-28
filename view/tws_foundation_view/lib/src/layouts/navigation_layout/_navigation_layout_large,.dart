part of 'navigation_layout.dart';

///
final class _MasterLayoutLarge extends _NavigationLayoutB {
  final List<ThemeI> appThemes;

  const _MasterLayoutLarge({
    required super.routeData,
    required super.page,
    required this.appThemes,
    super.rootRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _MasterLayoutHeader(
                appThemes: appThemes,
                rootRoute: rootRoute,
              ),
              Expanded(
                child: page,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
