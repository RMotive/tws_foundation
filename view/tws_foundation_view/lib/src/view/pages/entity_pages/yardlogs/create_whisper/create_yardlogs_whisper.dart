import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/catalog_options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/message_widgets/message_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_whisper_content.dart';
part '_whisper_truck_section.dart';
part '_whisper_driver_section.dart';
part '_whisper_trailer_section.dart';

/// {constant} default spacing between elements.
const double _kDefSpacing = 10;

/// Simplifies [Wrap] draw giving default spacing values.
final class _SpacedWrap extends StatelessWidget {
  /// Inner [Wrap.children] proxy value.
  final List<Widget> children;

  /// Creates a new [_SpacedWrap] instance.
  const _SpacedWrap({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _kDefSpacing,
      runSpacing: _kDefSpacing,
      children: children,
    );
  }
}

/// {whisper} class.
final class CreateYardLogsWhisper extends PageB {
  /// Creates a new [CreateYardLogsWhisper] instance.
  const CreateYardLogsWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create YardLog(s)',
      onPerform: () {},
      child: (_) => _CreateYardLogsWhisperContent(),
    );
  }
}
