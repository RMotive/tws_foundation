part of '../navigation_layout.dart';

/// {reactor} class.
/// 
/// Handles the state for each navigation entry button.
final class _EntryReactor extends ReactorB {

  /// Whether the entry is being hovered.
  bool onhover = false;

  /// Whether the entry is selected.
  bool selected = false;

  _EntryReactor(this.selected);
  
}

class __NavigationLayoutPageMenu extends StatefulWidget {
  /// Current active route (Incoming route).
  final Route currentRoute;

  /// Navigation entries to display.
  final List<NavigationLayoutEntryI> navigationEntries;

  const __NavigationLayoutPageMenu({required this.currentRoute, required this.navigationEntries});

  @override
  State<__NavigationLayoutPageMenu> createState() => __NavigationLayoutPageMenuState();
}

class __NavigationLayoutPageMenuState extends State<__NavigationLayoutPageMenu> {
  
  /// {state} reactors for each entry.
  List<_EntryReactor> entryReactors = <_EntryReactor>[];

  @override
  void initState() {
    for(int i = 0; i < widget.navigationEntries.length; i++){
      entryReactors.add(_EntryReactor(widget.navigationEntries[i].route == widget.currentRoute));
    }
    super.initState();
  }

  /// 

  @override
  Widget build(BuildContext context) {
    final FoundationThemeB theme  = Theming.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (int i = 0; i < widget.navigationEntries.length; i++) ...<Widget>[
              ReactiveWidget<_EntryReactor>(
                reactor: entryReactors[i],
                builder: (BuildContext ctx, _EntryReactor reactor) {
                  return _EntryButton(
                    entry: widget.navigationEntries[i],
                    textColor: theme.navigationLayout.fore,
                    onHoverBackgroundColor: theme.navigationLayout.fore,
                    onHoverTextColor: theme.navigationLayout.back,
                    backgroundColor: theme.navigationLayout.back,
                    evaluateSelection: () {
                      bool selected =  widget.navigationEntries[i].route == widget.currentRoute;
                      
                      /// Setting other reactors to unselected when this one is selected.
                      if(selected){
                        entryReactors.where((_EntryReactor oldreactor) => oldreactor.selected).forEach(
                          (_EntryReactor oldreactor) {
                            oldreactor.selected = false;
                            oldreactor.react();
                          },
                        );
                      }
                      reactor.selected = selected;
                      return selected;
                    },
                    reactor: reactor,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
