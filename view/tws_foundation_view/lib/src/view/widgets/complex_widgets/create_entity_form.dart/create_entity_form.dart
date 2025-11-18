import 'dart:async';
import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
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
final class CreateEntityForm<TEntity extends EntityI<TEntity>, TServiceI extends CreateServiceI<TEntity>> extends StatefulWidget {
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

  /// Builds a user-friendly message that identifies the entity that failed during record creation on the {server} side.
  /// 
  /// e.g: "Truck - {economic} - {plates} - etc..".
  final String Function(TEntity entity)? buildEntityTag;
  
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
    this.buildEntityTag,
    required this.formDesigner,
  }) : assert(
         (isMultiple && recordDesigner != null) || (!isMultiple && recordDesigner == null),
         'If IsMultiple is enabled the recordDesigner must be provided, otherwise if is disabled, recordDesigner must be null',
       );

  @override
  State<CreateEntityForm<TEntity, TServiceI>> createState() => _CreateEntityFormState<TEntity, TServiceI>();
}

/// {state} class.
///
/// Handles [State] for [CreateEntityForm].
final class _CreateEntityFormState<TEntity extends EntityI<TEntity>, TServiceI extends CreateServiceI<TEntity>> extends State<CreateEntityForm<TEntity, TServiceI>> {
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
  void didUpdateWidget(covariant CreateEntityForm<TEntity, TServiceI> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      widget.controller?.addListener(performCreate);
    }
  }

  /// Validate the creation content based on [TEntity.evaluation] method.
  /// 
  /// Return a boolean with the validation results.
  /// 
  /// If any entity not pass the [TEntity.evaluation] method, return a false.
  (List<TEntity>, bool) validateEntities(List<CreateEntityFormRecordReactor<TEntity>> recordReactor){
    List<TEntity> entities = <TEntity>[];
    int index = 0;
    for (CreateEntityFormRecordReactor<TEntity> record in recordReactors) {
      index++;
      TEntity entity = record.entity;
      entities.add(entity);
      
      /// Validated the record data.
      bool isValid = widget.validator?.call(entity) ?? true;
      List<EntityInvalidation<TEntity>> invalidations = entity.evaluate();
      record.isValid = isValid && invalidations.isEmpty;

      /// Update the record column when is invalid.
      if(!record.isValid){
        record.react();
        /// Mark the whole list as invalid.
        if(invalidations.isNotEmpty){
          showInvalidationDialog(entity, invalidations, index);
          return  (entities, false);
        }
      }
    }

    return (entities, true);
  }
  void showInvalidationDialog(TEntity entity, List<EntityInvalidation<TEntity>> invalidations, int index){

    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InvalidatingDialog(
          context: context,
          title: 'Wrong or missing information on record',
          header: 'Invalid information in ${widget.buildEntityTag?.call(entity)}.',
          router: _router,
          invalidations: invalidations,
        );
      },
    );
  }
  /// Performs the {create} operation for the current managed [TEntity] records.
  void performCreate() async {
    /// Stores the entities to create when 
    late List<TEntity> entities;

    /// Flag for any invalidated entity in entities list.
    late bool isValid;
    (entities, isValid) = validateEntities(recordReactors);
    List<UserFeedback> userFeedbacks = <UserFeedback>[];

    /// Return if any entity is invalid.
    if (!isValid){
      setState(() {});
      return;
    }

    if(widget.onCreate != null){
      userFeedbacks = await widget.onCreate!(entities);
    }
    String? errMessage;
    SessionStorageI sessionStorage = Injector.get();
    TServiceI creationService = Injector.get();
    FoundationResponseResolver<BatchOperationOutput<TEntity>> resolver = await creationService.create(
      entities,
      sessionStorage.token,
    ).onError((_, _) {
      errMessage = FoundationMessages.unknownServerException;
      showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            showCancelButton: false,
            title: 'Error',
            content: Text(
              FoundationMessages.unknownServerException
            ),
            theming: Theming.get<FoundationThemeB>(context).error,
            onAccept: () {
              _router.pop();
            },
          );
        },
      );
      return Future<FoundationResponseResolver<BatchOperationOutput<TEntity>>>.delayed(Duration.zero);
    });

    RichText? failureEntitiesMessage;
    resolver.resolve(
      objectBuilder: () => BatchOperationOutput<TEntity>(widget.entityFactory),
      onSuccess: (SuccessFrame<BatchOperationOutput<TEntity>> success) {
        List<EntityOperationFailure<TEntity>> failures = success.content.failures;
        if (failures.isNotEmpty) {
          errMessage = FoundationMessages.unknownServerException;
          failureEntitiesMessage = RichText(
            text: TextSpan(
              text: 'Cannot create some of the items, please verify the data and try again:\n\n',
              children:
                  widget.buildEntityTag != null
                      ? List<InlineSpan>.generate(failures.length, (int index) {
                        return TextSpan(
                          text: "${index + 1}.- ${widget.buildEntityTag!(failures[index].entity)}\n",
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Error: ${failures[index].message}\n\n',
                            ),
                          ],
                        );
                      })
                      : null,
            ),
          );

          showDialog(
            context: context,
            useRootNavigator: true,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                showCancelButton: false,
                title: 'Error Creating records.',
                richContent: failureEntitiesMessage!,
                onAccept: () {
                  _router.pop();
                },
              );
            },
          );

        }
      },
      onFailure: (FailureFrame failure, int status) {
        errMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errMessage = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errMessage = FoundationMessages.connectionError;
      },
      onFinally: () {
        if (errMessage == null && failureEntitiesMessage == null){
          _router.pop();
          return;
        } 

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Creating records.',
              content: Text(
                errMessage!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: Theming.get<FoundationThemeB>(context).error,
              onAccept: () {
                if (userFeedbacks.isEmpty) {
                  _router.pop();
                  widget.onClose?.call();
                  return;
                }
                _router.pop();
              },
            );
          },
        );
      },
    );

   
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
