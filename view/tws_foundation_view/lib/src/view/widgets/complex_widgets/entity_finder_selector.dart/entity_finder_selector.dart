import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/bordered_box.dart';
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

  /// Creates a new [EntityFinderSelector] instance.
  const EntityFinderSelector({
    super.key,
    this.label,
    required this.entityBuilder,
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

  @override
  void initState() {
    super.initState();

    inputFocusNode.addListener(
      () {
        if (inputFocusNode.hasFocus) {
          searchInvok = viewInvokation();
          overlayController.show();
        } else {
          overlayController.hide();
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theming.get(context);
  }

  @override
  void dispose() {
    inputFocusNode.dispose();

    super.dispose();
  }

  ///
  Future<ViewOutput<TEntity>> viewInvokation() async {
    SessionStorage sessionStorage = Injector.get();

    FoundationResponseResolver<ViewOutput<TEntity>> resolver = await service.view(
      ViewInput<TEntity>.b(2000, 1),
      sessionStorage.get(),
    );

    return resolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.entityBuilder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayController,
      child: CompositedTransformTarget(
        link: link,
        child: TextInput(
          label: widget.label,
          focusNode: inputFocusNode,
          autofocus: false,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            size: 32,
            color: theme.page.fore,
          ),
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
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: AsyncWidget<ViewOutput<TEntity>>(
                      future: searchInvok,
                      successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
                        return Center(
                          child: Text('There\'s data'),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
