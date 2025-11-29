part of '../navigation_layout.dart';

class _EntryButton extends StatefulWidget {

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
  final bool Function()? evaluateSelection;

  const _EntryButton({
    required this.entry,
    required this.textColor,
    required this.onHoverBackgroundColor,
    required this.onHoverTextColor,
    required this.backgroundColor,
    required this.evaluateSelection,
  });

  @override
  State<_EntryButton> createState() => __EntryButtonState();
}

class __EntryButtonState extends State<_EntryButton> {

  late bool onhover;

  late bool selected;

  @override
  void initState() {
    onhover = false;
    selected = widget.evaluateSelection?.call() ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick:() {
        setState(() {
          selected = widget.evaluateSelection?.call() ?? false;
          Router.i.go(widget.entry.route);
        });
      }, 
      onHover: (bool hover) {
        setState(() {
          onhover = hover;
        });
      },
      child: ColoredBox(
        color:
            onhover || selected
                ? widget.onHoverBackgroundColor.withAlpha(25)
                : widget.backgroundColor,
        child: SizedBox(
          height: 35,
          width: double.maxFinite,
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Selected Entry mark.
              if(selected)
              ColoredBox(
                color: widget.onHoverBackgroundColor,
                child: SizedBox(
                  width: 4,
                  height: double.maxFinite,
                ),
              ),

              /// Adding padding from spacing row property.
              if(!selected)
              SizedBox.shrink(),
              
              if(widget.entry.icon != null)
              Icon(
                widget.entry.icon,
                size: 20,
                color: widget.textColor,
              ),
              Text(
                widget.entry.title,
                style: TextStyle(
                  height: 1.0,
                  color: widget.textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}