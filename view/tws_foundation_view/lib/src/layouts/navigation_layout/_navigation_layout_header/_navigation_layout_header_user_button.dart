part of '../navigation_layout.dart';

///
final class _NavigationHeaderUserButton extends StatefulWidget {
  ///
  const _NavigationHeaderUserButton();

  @override
  State<_NavigationHeaderUserButton> createState() => _NavigationHeaderUserButtonState();
}

///
final class _NavigationHeaderUserButtonState extends State<_NavigationHeaderUserButton> {
  ///
  final OverlayPortalController _overlayPortalCtrlr = OverlayPortalController();

  ///
  bool isHover = false;

  final ThemeManagerI<FoundationThemeB> themeManager = Injector.getThemeManager();
  final UniqueKey themeEffectRef = UniqueKey();
  late SimpleTheming navigationLayoutTheming;

  @override
  void initState() {
    super.initState();

    navigationLayoutTheming = themeManager.get().navigationLayout;
  }

  @override
  Widget build(BuildContext context) {
    final SecurityServiceI securityService = Injector.get();

    return Tooltip(
      message: "User Account Options",
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onHover: (bool isOn) {
          setState(() {
            isHover = isOn;
          });
        },
        child: OverlayPortal(
          controller: _overlayPortalCtrlr,
          overlayChildBuilder: (_) {
            return Positioned(
              top: 55,
              right: 12,
              child: TapRegion(
                onTapOutside: (_) {
                  if (!isHover) {
                    _overlayPortalCtrlr.hide();
                  }
                },
                child: _NavigationLayoutHeaderUserButtonMenu(),
              ),
            );
          },
          child: TapRegion(
            onTapInside: (_) {
              _overlayPortalCtrlr.toggle();
            },
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints boxConstraints) {
                Color backgroundColor = navigationLayoutTheming.fore;
                if (isHover) {
                  backgroundColor = backgroundColor.withValues(
                    alpha: .8,
                  );
                }

                return AnimatedContainer(
                  duration: 200.miliseconds,
                  width: boxConstraints.maxHeight - 14,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // Main header user button content.
                    child: Text(
                      'LU',
                      style: TextStyle(
                        color: navigationLayoutTheming.back,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
