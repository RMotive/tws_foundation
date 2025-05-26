part of '../navigation_layout.dart';

class _MasterLayoutHeader extends StatelessWidget {
  const _MasterLayoutHeader();

  @override
  Widget build(BuildContext context) {
    final SimpleTheming theme = Theming.get<FoundationThemeB>().navigationLayout;

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
