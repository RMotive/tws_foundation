import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/view_consume_adapter.dart';
import 'package:tws_foundation_view/src/core/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/view/widgets/message_widgets/message_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/text_input.dart';
import 'package:tws_foundation_view/src/view/widgets/list_tile.dart';

part '_autocomplete_future.dart';
part '_autocomplete_list.dart';
part '_autocomplete_local.dart';
part '_autocomplete_not_found.dart';

/// State for future consume.
final class _TWSAutoCompleteFieldFutureState<T> extends ReactorB {
  List<T> preloadedItems = <T>[];
}

/// [AutoCompleteField] Custom component for TWS enviroment.
/// This component stores a list of posibles options to select for the user.
/// Performs a options filter based on user input text.
/// The Data is fetched throw Future async methods or non-async methods.
/// check properties descriptions. Not set both.
/// T generic must be an Object type for Future-async collections.
final class AutoCompleteField<T> extends StatefulWidget {
  /// Field width.
  final double width;

  /// Field height.
  final double height;

  /// Main title for the field.
  final String? label;

  /// Placeholder Text.
  final String? hint;

  /// Set an initial value. Use ONLY for forms state management.
  /// This value is searched in the adapter data soruce and selected automaticaly (if exist) on each repaint.
  final T? initialValue;

  /// Defines if the user can interact with the widget.
  final bool isEnabled;

  /// Set has non-required field, changing the border color when input is empty.
  final bool isOptional;

  /// Set the text to show at the end of [label] text.
  final String? suffixLabel;

  /// Optional Focus node to manage
  final FocusNode? focus;

  /// Variable that stores a [TWSFutureAutocompleteAdapter] class to consume the data (Only for async data).
  final ViewConsumeAdapter? adapter;

  /// List for process non-async data.
  final List<T>? nativeList;

  /// Method that returns the values to show and search in [TList] Object.
  final String Function(T?) displayValue;

  /// Optional text to show at the end of the [displayValue] result.
  final String Function(T?)? suffixResultLabel;

  /// Overlay menu height.
  final double menuHeight;

  /// Return the input text and the item property for last suggested item available based on the user input.
  final void Function(T? selection) onChanged;

  /// Optinal validator method for [TextInput] internal component.
  final String? Function(String?)? validator;

  ///The max number for search query in future consume;
  final int quantityResults;

  /// Get the a key identificator for the [T] object, to know when a set is selected or stored,
  /// usefull when manage creation forms with items that can be selected or created without this key idenfiticator.
  /// or handle a multi-set option.
  /// Set this property modify the [setSelection] method behavior with the search [tapSelection] property.
  /// This property has a default method initialitation that always return TRUE.
  final bool Function(T?)? hasKeyValue;

  const AutoCompleteField({
    super.key,
    required this.onChanged,
    required this.displayValue,
    this.adapter,
    this.nativeList,
    this.suffixLabel,
    this.initialValue,
    this.isOptional = false,
    this.focus,
    this.label,
    this.hint,
    this.width = 150,
    this.height = 40,
    this.menuHeight = 200,
    this.validator,
    this.isEnabled = true,
    this.quantityResults = 10,
    this.suffixResultLabel,
    this.hasKeyValue,
  }) : assert(
         nativeList != null || adapter != null,
         "At least one data type must be assigned",
       ),
       assert(
         nativeList == null || adapter == null,
         "Only one data type must be assigned (local or future-async)",
       );

  @override
  State<AutoCompleteField<T>> createState() => _AutoCompleteFieldState<T>();
}

class _AutoCompleteFieldState<T> extends State<AutoCompleteField<T>> with SingleTickerProviderStateMixin {
  final GlobalKey _fieldKey = GlobalKey();

  /// Future consume state.
  late _TWSAutoCompleteFieldFutureState<T> futureState;

  /// Consume method declaration in [adapter] property.
  Future<List<ViewOutput<dynamic>>> Function()? consume;

  /// Internal scroll controller for overlay scrolling.
  late final ScrollController scrollController;

  /// Color pallet for the component.
  late SimpleTheming primaryColorTheme;
  late SimpleTheming pageColorTheme;

  /// focus Node declaration.
  late final FocusNode focus;

  /// Link to attach ovelay component UI to the to the TWSInputText.
  final LayerLink link = LayerLink();

  /// Overlay controller.
  late OverlayPortalController overlayController;

  /// Main controller for the TWSInputText.
  late TextEditingController ctrl;

  /// Stores the current selected item.
  T? selectedOption;

  /// Stores the last selected value. If the last input is invalid, then stores null.
  T? previousSelection;

  /// Flag for componet first build.
  bool firstbuild = true;

  /// Original Options list given in builder parameter.
  List<T> rawOptionsList = <T>[];

  /// UI list. List to display on overlay menu, that shows the suggestions options.
  List<T> suggestionsList = <T>[];

  /// Flag to indicate if the overlay component is hovered.
  bool isOvelayHovered = false;

  /// Defines if the overlay is showing.
  bool show = false;

  /// Variable that contains the default initialization for [widget.hasKeyValue] property.
  late bool Function(T?) hasKeyValue;

  /// Stores the previous query value.
  String previousQuery = "";

  /// Methoth that verify if the [TWSTextField] component has a valid input selection.
  bool validSelection() {
    if (selectedOption == null && !widget.isOptional) return false;
    return true;
  }

  // Method to perform a local or future search, based on the given parameters.
  // This method manage the item selected and the data displayed on the overlay list view.
  //
  // Input: input text in TWSTextfield
  // Tap selection: Item selected via list overlay.
  void search(String input, {bool notifyChanges = true, T? tapSelection}) {
    selectedOption = tapSelection;
    String query = input.toLowerCase().trim();
    List<T> exactCoincidense = <T>[];

    /// filter the Original options list based on user input, for local data.
    if (widget.adapter == null) {
      if (query.isNotEmpty) {
        //Do a search for the method input variable for parcial results.
        suggestionsList =
            rawOptionsList.where((T set) {
              return widget.displayValue(set).toLowerCase().contains(query);
            }).toList();

        //Do a search for exact coincidenses.
        exactCoincidense =
            suggestionsList.where((T set) {
              return widget.displayValue(set).toLowerCase() == query;
            }).toList();

        if (suggestionsList.isNotEmpty && exactCoincidense.isNotEmpty) {
          if (!firstbuild) ctrl.text = input;
          selectedOption = exactCoincidense.first;
        }
      } else {
        // if the input is empty, then the default suggestions list is the original options list.
        suggestionsList = rawOptionsList;
      }
      if (!firstbuild) {
        setState(() {
          if (notifyChanges && previousSelection != selectedOption) {
            widget.onChanged(selectedOption);
          }
        });
      }
      previousSelection = selectedOption;
    } else {
      // Search data using the adapter given in parameters.
      // When this method is used, is necesary to tap in any option to set an item selection.
      if (query.isNotEmpty) {
        //Do a search for exact coincidenses.
        if (tapSelection == null) {
          exactCoincidense =
              suggestionsList.where((T set) {
                return widget.displayValue(set).toLowerCase() == query;
              }).toList();

          if (!firstbuild && suggestionsList.isNotEmpty && exactCoincidense.isNotEmpty) {
            selectedOption = exactCoincidense.first;
          }
        }
      }

      // Trigger the Onchange callback when a search is triggered.
      if (!firstbuild) {
        //Check if is necesary a list refresh.
        if (tapSelection == null) {
          if (query.isEmpty) {
            futureState.preloadedItems = rawOptionsList;
            if (mounted) futureState.react();
          } else if (query.isNotEmpty) {
            futureState.preloadedItems = <T>[];
          }
        }
        if (notifyChanges && previousSelection != selectedOption) {
          widget.onChanged(selectedOption);
        }
      }
      previousSelection = selectedOption;
      previousQuery = query;
    }
  }

  void _scrollFocus() {
    // Center scroll to control field.
    Scrollable.ensureVisible(
      _fieldKey.currentContext ?? context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.2, // aligment ratio
    );
  }

  /// Method that manage and assign the [initialValue] property.
  void setSelection(bool notifyChanges) {
    if (widget.initialValue != null && hasKeyValue(widget.initialValue)) {
      String value = widget.displayValue(widget.initialValue);
      search(
        value,
        tapSelection: hasKeyValue(widget.initialValue) ? widget.initialValue : null,
        notifyChanges: notifyChanges,
      );
      ctrl.text = widget.displayValue(widget.initialValue);
    } else {
      if (previousSelection != null || ctrl.text != "") {
        ctrl.text = "";
        search("", notifyChanges: notifyChanges);
      }
    }
  }

  void initializeThemes() {
    FoundationThemeB theme = Theming.get<FoundationThemeB>(context);
    primaryColorTheme = theme.control;
    pageColorTheme = theme.page;
  }

  /// Method that manage the focus events to show or hide the overlay
  void focusManager() {
    if (focus.hasFocus) {
      if (firstbuild) overlayController.show();
      _scrollFocus();
      setState(() => show = true);
    } else {
      setState(() {
        show = false;
      });
    }
  }

  void onTileTap(String label, T? item) {
    setState(() {
      ctrl.text = label;
      search(label, tapSelection: item);
      show = false;
    });
  }

  @override
  void didChangeDependencies() {
    initializeThemes();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    futureState = _TWSAutoCompleteFieldFutureState<T>();
    hasKeyValue = widget.hasKeyValue ?? (T? set) => true;
    scrollController = ScrollController();
    ctrl = TextEditingController(
      text: widget.initialValue != null ? widget.displayValue(widget.initialValue) : null,
    );
    focus = widget.focus ?? FocusNode();
    overlayController = OverlayPortalController();
    if (widget.initialValue != null) selectedOption = widget.initialValue;
    if (widget.adapter != null) {
      consume = () => widget.adapter!.consume(widget.quantityResults, 1, '');
    } else {
      rawOptionsList = widget.nativeList!;
    }
    focus.addListener(focusManager);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoCompleteField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Set a new local list if changes.
    if (widget.nativeList != null && (widget.nativeList != oldWidget.nativeList)) {
      rawOptionsList = widget.nativeList!;
      suggestionsList = rawOptionsList;
    }
    //Set the selection if changes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setSelection(true);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color highContrastColor = primaryColorTheme.foreAlt ?? primaryColorTheme.fore;
    const double tileHeigth = 35;
    return SizedBox(
      width: widget.width,
      child: OverlayPortal(
        controller: overlayController,
        child: CompositedTransformTarget(
          link: link,
          child: TextInput(
            deBounce: const Duration(milliseconds: 300),
            autofocus: false,
            controller: ctrl,
            isOptional: widget.isOptional,
            width: widget.width,
            height: widget.height,
            suffixLabel: widget.suffixLabel,
            showErrorColor: (selectedOption == null && (!widget.isOptional || ctrl.text.isNotEmpty)) && !firstbuild,
            onChanged: (String text) => search(text),
            focusNode: focus,
            label: widget.label,
            hint: widget.hint,
            isEnabled: widget.isEnabled,
            onTap: () {
              if (!show) setState(() => show = true);
            },
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              size: 24,
              color: primaryColorTheme.fore,
            ),
            validator: (String? text) {
              if (!validSelection()) {
                return "Not exist an item with this value.";
              }
              if (widget.validator != null) return widget.validator!(text);
              return null;
            },
          ),
        ),
        overlayChildBuilder: (_) {
          // Getting the visual boundries for this component.
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Size renderSize = renderBox.size;
          return Positioned(
            width: renderSize.width,
            child: CompositedTransformFollower(
              showWhenUnlinked: false,
              offset: Offset(0, renderSize.height),
              link: link,
              // Overlay pointer handler
              child: PointerArea(
                onHover: (bool hover) => isOvelayHovered = hover,
                // Handle mobile gestures.
                child: TextFieldTapRegion(
                  child: Visibility(
                    visible: show,
                    maintainState: true,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: widget.menuHeight),
                      child: ClipRRect(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: FoundationColors.ligthGrey,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5),
                            ),
                            border: Border(
                              right: BorderSide(
                                width: 2,
                                color: FoundationColors.oceanBlue,
                              ),
                              left: BorderSide(
                                width: 2,
                                color: FoundationColors.oceanBlue,
                              ),
                              bottom: BorderSide(
                                width: 2,
                                color: FoundationColors.oceanBlue,
                              ),
                            ),
                          ),
                          child:
                              widget.adapter != null
                                  ? _TWSAutocompleteFuture<T>(
                                    controller: scrollController,
                                    tileHeigth: tileHeigth,
                                    displayLabel: widget.displayValue,
                                    theme: primaryColorTheme,
                                    loadingColor: highContrastColor,
                                    hoverTextColor: pageColorTheme.fore,
                                    suffixLabel: widget.suffixResultLabel,
                                    state: futureState,
                                    onTap: (String label, T? item) => onTileTap(label, item),
                                    consume:
                                        () => widget.adapter!.consume(
                                          1,
                                          widget.quantityResults,
                                          firstbuild ? "" : ctrl.text.trim(),
                                        ),
                                    onFetch: (
                                      List<ViewOutput<dynamic>> data,
                                      _TWSAutoCompleteFieldFutureState<T> state,
                                    ) {
                                      futureState = state;
                                      if (!firstbuild && (ctrl.text.trim().isEmpty || selectedOption != null)) {
                                        state.preloadedItems = rawOptionsList;
                                      } else {
                                        //Stores the properties results
                                        for (ViewOutput<dynamic> view in data) {
                                          suggestionsList.addAll(
                                            view.entities as Iterable<T>,
                                          );
                                          if (firstbuild) {
                                            rawOptionsList.addAll(
                                              view.entities as Iterable<T>,
                                            );
                                          }
                                        }
                                      }

                                      firstbuild = false;
                                    },
                                  )
                                  : _TWSAutocompleteNative<T>(
                                    controller: scrollController,
                                    suggestions: suggestionsList,
                                    displayLabel: widget.displayValue,
                                    theme: primaryColorTheme,
                                    onTap: (String label, T? item) => onTileTap(label, item),
                                    loadingColor: highContrastColor,
                                    hoverTextColor: pageColorTheme.fore,
                                    onFirstBuild: () {
                                      search(ctrl.text);
                                      firstbuild = false;
                                      return suggestionsList;
                                    },
                                    tileHeigth: tileHeigth,
                                    firstBuild: firstbuild,
                                    rawData: widget.nativeList!,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
