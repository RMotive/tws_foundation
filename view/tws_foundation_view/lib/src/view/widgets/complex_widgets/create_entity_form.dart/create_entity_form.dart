import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_create_entity_form_records_column.dart';

///
typedef RecordDesigner<TEntity extends EntityI<TEntity>> = Widget Function(TEntity entity, bool selected, bool valid);

///
const double _kPadding = 8;

///
const double _kColWidthLimit = 300;

/// {widget} class.
///
///
/// [TEntity] entity type to be created.
///
///
/// Handles the creation and submit of [TEntity] entites, displaying a custom creation form for items and display a list of added items and it's current values.
final class CreateEntityForm<TEntity extends EntityI<TEntity>> extends StatefulWidget {
  /// [TEntity] default object factory.
  final TEntity Function() entityFactory;

  /// Whether this form supports multiple records creation.
  final bool isMultiple;

  /// {event} triggered after the form got closed.
  final VoidCallback? onClose;

  /// [TEntity] validation function.
  final bool Function(TEntity entity)? validator;

  /// Controller.
  final CreateEntityFormController? controller;

  /// Function to build the summary [Widget] to show at the created entity stack as summary data.
  final RecordDesigner<TEntity>? recordDesigner;

  /// Form designer.
  final Widget Function(CreateEntityFormRecordReactor<TEntity>? itemState) formDesigner;

  /// A [FutureOr] list for the submit of the added items, returning the result [EntityCreationFormFeedback] status.
  final FutureOr<List<UserFeedback>> Function(List<TEntity> entities)? onCreate;

  /// Creates a new [CreateEntityForm] instance.
  const CreateEntityForm({
    super.key,
    required this.entityFactory,
    this.isMultiple = true,
    this.controller,
    this.validator,
    this.onCreate,
    this.onClose,
    this.recordDesigner,
    required this.formDesigner,
  }) : assert(
         (isMultiple && recordDesigner != null) || (!isMultiple && recordDesigner == null),
         'If IsMultiple is enabled the recordDesigner must be provided, otherwise if is disabled, recordDesigner must be null',
       );

  @override
  State<CreateEntityForm<TEntity>> createState() => _CreateEntityFormState<TEntity>();
}

/// {state} class.
///
/// Handles [State] for [CreateEntityForm].
final class _CreateEntityFormState<TEntity extends EntityI<TEntity>> extends State<CreateEntityForm<TEntity>> {
  /// Application routing service.
  final Router _router = Injector.get();

  /// Color pallet for the component.
  late SimpleTheming theming;

  ///
  late CreateEntityFormRecordReactor<TEntity> currRecordReactor;

  ///
  List<CreateEntityFormRecordReactor<TEntity>> recordReactors = <CreateEntityFormRecordReactor<TEntity>>[];

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(performCreate);

    currRecordReactor = CreateEntityFormRecordReactor<TEntity>(
      widget.entityFactory(),
    );

    recordReactors.add(currRecordReactor);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theming = Theming.get<FoundationThemeB>(context).control;
  }

  @override
  void didUpdateWidget(covariant CreateEntityForm<TEntity> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      widget.controller?.addListener(performCreate);
    }
  }

  /// Performs the {create} operation for the current managed [TEntity] records.
  void performCreate() async {
    if (widget.onCreate == null) return;

    bool areInvalid = false;
    final List<TEntity> entities = <TEntity>[];
    for (CreateEntityFormRecordReactor<TEntity> recordReactor in recordReactors) {
      TEntity entity = recordReactor.entity;
      entities.add(entity);

      if (widget.validator == null) {
        continue;
      }

      bool isValid = widget.validator!(entity);
      recordReactor.isValid = isValid;
      if (!isValid && !areInvalid) {
        areInvalid = true;
      }
    }

    if (areInvalid) {
      setState(() {});
      return;
    }

    List<UserFeedback> userFeedbacks = await widget.onCreate!(entities);
    if (userFeedbacks.isEmpty) {
      _router.pop();
      widget.onClose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints cts) {
        double calcWidth = ((cts.maxWidth / 2) - _kPadding);

        Size sizeFactor = const BoxConstraints(
          minWidth: _kColWidthLimit,
        ).constrain(
          Size(calcWidth, cts.maxHeight),
        );

        if (sizeFactor.width <= _kColWidthLimit) {
          sizeFactor = Size(cts.maxWidth, sizeFactor.height);
        }

        if (!widget.isMultiple) {
          sizeFactor = Size(cts.maxWidth, sizeFactor.height);
        }

        return Padding(
          padding: const EdgeInsets.all(_kPadding),
          child: Wrap(
            children: <Widget>[
              /// --> Entity edition form
              SizedBox.fromSize(
                size: sizeFactor,
                child: SectionWidget(
                  title: 'Properties',
                  child: widget.formDesigner(currRecordReactor),
                ),
              ),

              /// --> Records summary stack.
              if (widget.isMultiple)
                SizedBox.fromSize(
                  size: sizeFactor,
                  child: _CreateEntityFormRecordsColumn<TEntity>(
                    width: sizeFactor.width,
                    recordReactors: recordReactors,
                    recordDesigner: widget.recordDesigner!,
                    onAdd: () {
                      setState(() {
                        CreateEntityFormRecordReactor<TEntity> record = CreateEntityFormRecordReactor<TEntity>(
                          widget.entityFactory(),
                        );
                        currRecordReactor = record;
                        recordReactors.add(record);
                      });
                    },
                    onRemove: () {
                      setState(() {
                        recordReactors.remove(currRecordReactor);
                      });
                    },
                    onSelect:(CreateEntityFormRecordReactor<TEntity> selected) {
                      setState(() {
                        currRecordReactor = selected;
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
