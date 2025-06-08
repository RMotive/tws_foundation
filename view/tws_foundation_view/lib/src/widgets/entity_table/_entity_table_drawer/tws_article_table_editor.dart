part of '../entity_table.dart';

/// [TWSArticleTableEditor] Record update editor form for [EntityTable].
final class TWSArticleTableEditor extends StatelessWidget {
  /// Form content.
  final Widget form;

  /// On cancel or close form editor.
  final Function onCancel;

  /// On save form.
  final FutureOr<void> Function()? onSave;

  const TWSArticleTableEditor({
    super.key,
    this.onSave,
    required this.form,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // --> Editor actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: <Widget>[
            _EntityTableDrawerAction(
              icon: Icons.close_rounded,
              action: 'Cancel editing',
              onClick: () => onCancel(),
            ),
            if (onSave != null)
              _EntityTableDrawerAction(
                icon: Icons.save_alt_rounded,
                action: 'Save',
                onClick: () async {
                  await onSave?.call();
                },
              ),
          ],
        ),

        // --> Custom content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(child: form),
          ),
        ),
      ],
    );
  }
}
