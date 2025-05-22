part of 'auth_page.dart';

///
final class _AuthPageBusinessLogo extends StatelessWidget {
  ///
  const _AuthPageBusinessLogo();

  @override
  Widget build(BuildContext context) {
    final FoundationThemeB theme =
        Injector.getThemeManager<FoundationThemeB>().get();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 350),
        child: AspectRatio(
          aspectRatio: 1 / .75,
          child: Image(
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
            image: AssetImage(theme.authPageBusinessLogoAssetAccess),
          ),
        ),
      ),
    );
  }
}
