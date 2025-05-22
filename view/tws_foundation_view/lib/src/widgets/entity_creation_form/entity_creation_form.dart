import 'dart:async';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_view/src/widgets/entity_creation_form/entity_creation_form_feedback.dart';
import 'package:tws_foundation_view/src/widgets/entity_creation_form/entity_creation_form_item_reactor.dart';
import 'package:tws_foundation_view/src/widgets/tws_section.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_entity_creation_form_reactor.dart';
part 'tws_article_creator_records_stack.dart';

const double _kPadding = 8;
const double _kColWidthLimit = 300;

/// {Widget} class.
///
/// [T] - model type that is intended to be handled by the creator.
///
/// Handles the creation and submit of [T] entites, displaying a custom creation form for items and display a list of added items and it's current values.
final class EntityCreationForm<T> extends StatefulWidget {
  /// Generic method to build new [T] items.
  final T Function() factory;

  /// Event triggered after the form got closed.
  final VoidCallback? onClose;

  /// Method to validate [T] and notify the invalid item.
  final bool Function(T entity)? validator;

  /// Form controller.
  final EntityCreationFormController? controller;

  /// Entry item designer.
  final Widget Function(T entity, bool selected, bool valid) entryDesigner;

  /// Form designer.
  final Widget Function(EntityCreationFormItemReactor<T>? itemState)
  formDesigner;

  /// A [FutureOr] list for the submit of the added items, returning the result [EntityCreationFormFeedback] status.
  final FutureOr<List<EntityCreationFormFeedback>> Function(List<T> records)?
  onCreate;

  const EntityCreationForm({
    super.key,
    this.controller,
    this.onCreate,
    this.validator,
    this.onClose,
    required this.factory,
    required this.entryDesigner,
    required this.formDesigner,
  });

  @override
  State<EntityCreationForm<T>> createState() => _EntityCreationFormState<T>();
}

class _EntityCreationFormState<TModel>
    extends State<EntityCreationForm<TModel>> {
  final Router router = Injector.get();

  late _EntityCreationFormReactor<TModel> mainState;

  /// Theme Manager injector.
  final ThemeManagerI<FoundationThemeB> themeManager =
      Injector.getThemeManager();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late SimpleTheming pageColorTheme;

  @override
  void initState() {
    super.initState();
    mainState = _EntityCreationFormReactor<TModel>(widget.factory);
    pageColorTheme = themeManager.get().primaryControlColor;
    themeManager.addEffect(ref, themeUpdateListener);
    widget.controller?.addListener(submitRecords);
  }

  @override
  void didUpdateWidget(covariant EntityCreationForm<TModel> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller?.addListener(submitRecords);
  }

  @override
  void dispose() {
    themeManager.removeEffect(ref);
    super.dispose();
  }

  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      pageColorTheme = theme.primaryControlColor;
    });
  }

  void submitRecords() async {
    FutureOr<List<EntityCreationFormFeedback>> Function(List<TModel> models)?
    creator = widget.onCreate;
    bool Function(TModel)? validator = widget.validator;
    if (creator == null) return;
    List<TModel> models = <TModel>[];

    if (validator != null) {
      bool error = false;

      for (EntityCreationFormItemReactor<TModel> state in mainState.states) {
        TModel model = state.model;
        models.add(model);

        bool isValid = validator(model);
        state.updateInvalid(isValid);
        if (isValid) continue;
        error = true;
      }

      mainState.react();
      if (error) {
        return;
      }
    } else {
      models =
          mainState.states
              .map((EntityCreationFormItemReactor<TModel> i) => i.model)
              .toList();
    }

    List<EntityCreationFormFeedback> feedbacks = await creator(models);
    if (feedbacks.isEmpty) {
      router.pop();
      widget.onClose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveWidget<_EntityCreationFormReactor<TModel>>(
      reactor: mainState,
      builder: (
        BuildContext context,
        _EntityCreationFormReactor<TModel> state,
      ) {
        return LayoutBuilder(
          builder: (_, BoxConstraints cts) {
            final double calcWidth = ((cts.maxWidth / 2) - _kPadding);
            Size sizeFactor = const BoxConstraints(
              minWidth: _kColWidthLimit,
            ).constrain(Size(calcWidth, cts.maxHeight));
            if (sizeFactor.width <= _kColWidthLimit) {
              sizeFactor = Size(cts.maxWidth, sizeFactor.height);
            }

            return Padding(
              padding: const EdgeInsets.all(_kPadding),
              child: Wrap(
                children: <Widget>[
                  SizedBox.fromSize(
                    size: sizeFactor,
                    child: TWSSection(
                      title: 'Properties',
                      content: widget.formDesigner(
                        state.states.isEmpty
                            ? null
                            : state.states[state.current],
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: sizeFactor,
                    child: _RecordsStack<TModel>(
                      add: state.addItem,
                      remove: state.removeItem,
                      pageTheme: pageColorTheme,
                      states: state.states,
                      creatorWidth: sizeFactor.width,
                      itemDesigner: widget.entryDesigner,
                      changeItem: state.changeSelection,
                      currentItemIndex: state.current,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
