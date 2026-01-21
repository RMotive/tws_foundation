import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/bordered_box.dart';
import 'package:tws_foundation_view/src/view/widgets/list_tile.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a complex [Widget] that allows to find [EntityI] items and select them.
final class EntityFinderSelector<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
  /// [TEntity] builder for conversion.
  final EntityBuilder<TEntity> entityBuilder;

  /// Input label decorator.
  final String? label;

  /// Whether the component is enabled.
  final bool enabled;

  /// Build a custom label text for the [TEntity] items list.
  final String Function(TEntity) textBuilder;

  /// Pre-selected value for the widget.
  final TEntity? initialValue;

  /// Callback called when an [TEntity] item is selected.
  final void Function(TEntity?)? onSelected;

  /// Optional list of attributes paths to filter the selectable entities, based on the user input text.
  /// 
  /// If this property is null, no filtering will be applied and the search function will not be excecuted.
  /// 
  /// The exact property path must be provided as defined in the [TEntity] model.
  /// 
  /// Example for [Yardlog] as [TEntity]: '${YardLog.kSection}.${EntityKeys.name}', 
  /// this means that the section name property will be used to filter the selectable entities.
  ///
  /// To add more more filters, just add more paths to the list.
  /// 
  /// The default filter behavior is OR and CONTAINS, so if any of the properties contains the input text, the entity will be included in the results.
  final List<String>? filterBy;

  /// Callback called when the overlay visibility changes.
  final void Function(bool isVisible)? overlayStatus;


  /// Creates a new [EntityFinderSelector] instance.
  const EntityFinderSelector({
    super.key,
    this.label,
    this.enabled = true,
    this.initialValue,
    this.onSelected,
    this.filterBy,
    this.overlayStatus,
    required this.entityBuilder,
    required this.textBuilder,
  });

  @override
  State<EntityFinderSelector<TEntity, TService>> createState() => _EntityFinderSelectorState<TEntity, TService>();
}

/// {state} class.
///
/// Handles [State] for [EntityFinderSelector].
final class _EntityFinderSelectorState<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<EntityFinderSelector<TEntity, TService>> {
  /// {dep} [TEntity] based service dependency.
  final TService service = Injector.get();

  /// Inner [TextInput] focus node controller.
  final FocusNode inputFocusNode = FocusNode();

  /// Link to attach ovelay component UI to the to the TWSInputText.
  final LayerLink link = LayerLink();

  /// Overlay portal controller.
  final OverlayPortalController overlayController = OverlayPortalController();

  /// {state} current application theme data.
  late FoundationThemeB theme = Theming.get(context);

  /// {state} current [Future] instance for the data gathering search invokation.
  late Future<ViewOutput<TEntity>> searchInvok;

  /// {state} whether currently there's an error to display in the input [Widget].
  String? error;

  /// {state} [TextEditingController] for the input text.
  late final TextEditingController inputcontroller;

  /// Get a key identificator for the [TEntity] object, to know when a set is a valid initial value,
  /// usefull when manage creation forms with items that can be selected or created without this key idenfiticator (Like id property in [TEntity] models).
  /// or handle a multi-set option, this function result modiefies the behavior for pre-selected values.
  late final bool Function(TEntity?) hasKeyValue;

  /// {state} current selection of the [TEntity] item.
  TEntity? currentSelection;

  /// {state} behavior scroll controller.
  final ScrollController scrollController = ScrollController();

  /// Stores the max [TEntity] view pages available.
  late int viewPagesAvailable;

  /// Current view page reached by lazzy loading.
  int currentViewPage = 1;

  /// List that contains all the entities loaded in selectable list.
  List<TEntity> entitiesList = <TEntity>[];

  /// View loading status for lazzy list behavior.
  bool loadingView = false;

  /// Previous search value to avoid duplicate searches.
  String previousSearch = '';

  /// Current applied filters in the view service.
  List<ViewFilterNodeI<TEntity>> currentFilters = <ViewFilterNodeI<TEntity>>[];

  /// Trigger the view service method for lazzy loadings and filters.
  void reloadEntities(bool isLazzy) {
    if(!loadingView){
      setState(() {
        loadingView = true;
        searchInvok = viewInvokation(isLazzy);
      });
    }
  }

  List<ViewFilterNodeI<TEntity>> searchInput(String value){    
    previousSearch = value;
    if(widget.filterBy == null) return <ViewFilterNodeI<TEntity>>[];

    currentViewPage = 1;
    entitiesList.clear();
    if(value.cleaned == null) return <ViewFilterNodeI<TEntity>>[];
  

    /// Store logicals filters.
    final List<ViewFilterProperty<TEntity>> validLogicalFilterList = <ViewFilterProperty<TEntity>>[];

    for (String path in widget.filterBy!) {
      validLogicalFilterList.add(
        ViewFilterProperty<TEntity>.a(
          property: path,
          operator: ViewFilterOperators.contains,
          value: value,
        ),
      );
    }
    ViewFilterLogical<TEntity> filter = ViewFilterLogical<TEntity>(
      1,
      ViewFilterLogicalOperators.or,
      validLogicalFilterList,
    );
    filter.discriminator = ViewFilterDiscriminator.viewFilterLogical.name;

    return <ViewFilterNodeI<TEntity>>[filter]; 
  }

  /// Manage the service view data consume to populate the list content.
  Future<ViewOutput<TEntity>> viewInvokation(bool isLazzy) async {
    SessionStorageI sessionStorage = Injector.get();

    currentFilters = isLazzy ? currentFilters: searchInput(inputcontroller.text);

    FoundationResponseResolver<ViewOutput<TEntity>> resolver = await service.view(
      ViewInput<TEntity>.a(10, currentViewPage, <ViewOrdering>[], currentFilters),
      sessionStorage.token,
    );

    ViewOutput<TEntity> result =  resolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.entityBuilder),
    );

    viewPagesAvailable = result.pages;
    entitiesList.addAll(result.entities);
    currentViewPage++;
    result.entities = entitiesList;
    loadingView = false;
    return result;
  }

  @override
  void initState() {
    super.initState();
    currentSelection = widget.initialValue;
    // Initialize method to Check for a valid id in [widget.initialvalue] property, 
    // if the id is not set, then the item is behing created on the fly, and not is valid as initial value.
    hasKeyValue = (TEntity? set) {
      if(set == null) return true;
      return set.id > BigInt.zero;
    };

    inputcontroller =
        widget.initialValue != null
            ? TextEditingController(text: widget.textBuilder(currentSelection!).trim())
            : TextEditingController();

    inputFocusNode.addListener(
      () {
        if (inputFocusNode.hasFocus) {
          if(entitiesList.isEmpty) searchInvok = viewInvokation(false);
          overlayController.show();
          widget.overlayStatus?.call(true);
        } else {
          overlayController.hide();
          widget.overlayStatus?.call(false);
        }
      },
    );

    scrollController.addListener((){
      if ((scrollController.position.pixels > scrollController.position.maxScrollExtent - 35) && viewPagesAvailable >= currentViewPage) {
        reloadEntities(true);
      }
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theming.get(context);
  }

  @override
  void didUpdateWidget(covariant EntityFinderSelector<TEntity, TService> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      error = null;
    }
    /// Set initial values.
    if(oldWidget.initialValue != widget.initialValue) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (widget.initialValue != null && hasKeyValue(widget.initialValue)) {
            currentSelection = widget.initialValue;
            inputcontroller.text = widget.textBuilder(currentSelection!);
          } else {
            currentSelection = null;
            inputcontroller.clear();
          }
        },
      );
    }
  }

  @override
  void dispose() {
    // Dispose defined controllers.
    // [TextInput] widget dispose the Input and Focus controllers.
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayController,
      child: CompositedTransformTarget(
        link: link,
        child: TextInput(
          label: widget.label,
          isEnabled: widget.enabled,
          focusNode: inputFocusNode,
          errorText: error,
          autofocus: false,
          controller: inputcontroller,
          deBounce: const Duration(milliseconds: 300),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            size: 32,
            color: theme.page.fore,
          ),
          onChanged: (String text) {
            // --> Clean selected item.
            if(text.trim().isEmpty && widget.onSelected != null) widget.onSelected!(null);
            if((previousSearch != inputcontroller.text) && !loadingView) reloadEntities(false);

          },
        ),
      ),
      overlayChildBuilder: (BuildContext overlayChildContext) {
        RenderBox inputBox = context.findRenderObject() as RenderBox;
        Size inputSize = inputBox.size;

        return Positioned(
          width: inputSize.width,
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: Offset(0, inputSize.height),
            child: ColoredBox(
              color: theme.page.back,
              child: BorderedBox(
                color: theme.page.accent,
                child: AsyncWidget<ViewOutput<TEntity>>(
                  future: searchInvok,
                  errorBuilder: (BuildContext ctx, Object? error, ViewOutput<TEntity>? data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          'Error Loading Data',
                          style: TextStyle(
                            color: theme.warning.fore,
                          ),
                        ),
                      ),
                    );
                  },
                  successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
                    Iterable<TEntity> entities = data.entities;
                
                    if (entities.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            'No results to display',
                            style: TextStyle(
                              color: theme.control.fore,
                            ),
                          ),
                        ),
                      );
                    }
                
                    /// ---> Move scroll to new content on lazzy loads.
                    if (loadingView && currentViewPage > 1) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => scrollController.jumpTo(scrollController.position.maxScrollExtent - 400),
                      );
                    }
                
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 250,
                      ),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: TextFieldTapRegion(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemExtent: 35,
                            controller: scrollController,
                            itemCount: data.entities.length,
                            itemBuilder: (_, int index) {
                              final TEntity entity = data.entities.elementAt(index);
                              final String label = widget.textBuilder(entity);
                              // Build the individual option component.
                              return CollectionTile(
                                label: label,
                                width: double.maxFinite,
                                textColor: theme.page.fore,
                                onHoverColor: theme.page.accent,
                                enabled: widget.enabled,
                                onTap: (bool selected) {
                                  if (selected) {
                                    setState(() {
                                      inputFocusNode.unfocus();
                                      overlayController.hide();
                                      widget.overlayStatus?.call(false);

                                      currentSelection = entity;
                                      inputcontroller.text = widget.textBuilder(entity);
                                      widget.onSelected?.call(currentSelection);
                                    });
                                  }
                                },
                              );
                            },
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
      },
    );
  }
}
