import 'package:csm_view/csm_view.dart';import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/// [TwsArticleCreationStackItemProperty] Dedicated class to display the current item property value in [TWSArticleCreator].
final class TwsArticleCreationStackItemProperty extends StatelessWidget {
  /// Propertie title.
  final String label;
  /// Propertie value.
  final String? value;
  /// Min text component width.
  final double? minWidth;
  /// Max text component width.
  final double? maxWidth;

  const TwsArticleCreationStackItemProperty({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    String val = (value?.isEmpty ?? true) ? '---' : value!;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? maxWidth ?? 0,
        maxWidth: maxWidth ?? double.maxFinite,
      ),
      child: CSMSpacingColumn(
        crossAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: <Widget>[
          Text('$label:'),
          Text(
            val,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
