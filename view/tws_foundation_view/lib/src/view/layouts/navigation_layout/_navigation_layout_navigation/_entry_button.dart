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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: PointerArea(
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
          color: onhover || selected ? widget.onHoverBackgroundColor : widget.backgroundColor,
          child: BorderedBox(
            color: widget.textColor,
            child: SizedBox(
              height: 30,
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 8),
                child: Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if(widget.entry.icon != null)
                    Icon(
                      widget.entry.icon,
                      size: 20,
                      color: onhover || selected? widget.onHoverTextColor : widget.textColor,
                    ),
                    Text(
                      widget.entry.title,
                      style: TextStyle(
                        height: 1.0,
                        color: onhover || selected ? widget.onHoverTextColor: widget.textColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}