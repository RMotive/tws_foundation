part of 'navigation_layout.dart';

///
final class _MasterLayoutLarge extends _NavigationLayoutB {
  const _MasterLayoutLarge({
    required super.routeData,
    required super.page,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              const _MasterLayoutHeader(),
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
