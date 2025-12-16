part of '../navigation_layout.dart';

class _EntryButton extends StatelessWidget {

  /// Entry data
  final NavigationLayoutEntryI entry;
  
  /// Background color.
  final Color backgroundColor;

  /// Tile background color when hover event is triggered.
  final Color onHoverBackgroundColor;

  /// Text color.
  final Color textColor;

  /// Tile text color when hover event is triggered.
  final Color? onHoverTextColor;

  /// Optional method to evaluate if the tile is selected.
  final bool Function() evaluateSelection;

  /// State instance manager.
  final _EntryReactor reactor;

  const _EntryButton({
    required this.entry,
    required this.textColor,
    required this.onHoverBackgroundColor,
    required this.onHoverTextColor,
    required this.backgroundColor,
    required this.evaluateSelection,
    required this.reactor,
  });

@override
  Widget build(BuildContext context) {
    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick:() {
        reactor.selected = evaluateSelection();
        reactor.react();
        Router.i.go(entry.route);
      }, 
      onHover: (bool hover) {
        reactor.onhover = hover;
        reactor.react();
      },
      child: ColoredBox(
        color:
            reactor.onhover || reactor.selected
                ? onHoverBackgroundColor.withAlpha(25)
                : backgroundColor,
        child: SizedBox(
          height: 35,
          width: double.maxFinite,
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Selected Entry mark.
              if(reactor.selected)
              ColoredBox(
                color: onHoverBackgroundColor,
                child: SizedBox(
                  width: 4,
                  height: double.maxFinite,
                ),
              ),

              /// Adding padding from spacing row property.
              if(!reactor.selected)
              SizedBox.shrink(),
              
              if(entry.icon != null)
              Icon(
                entry.icon,
                size: 20,
                color: textColor,
              ),
              Text(
                entry.title,
                style: TextStyle(
                  height: 1.0,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
