import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class YardLogsPageCreateWhisper extends PageB {
  /// Creates a new [YardLogsPageCreateWhisper] instance.
  const YardLogsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create YardLog(s)',
      onPerform: () {},
      child: CreateEntityForm<YardLog>(
        entityFactory: () => YardLog(),
        isMultiple: false,
        formDesigner: (CreateEntityFormRecordReactor<YardLog>? itemState) {
          YardLog entity = itemState!.entity;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              children: <Widget>[
                /// --> YardLog Entry
                OptionsSelector<bool>(
                  height: 100,
                  fontSize: 30,
                  options: <OptionsSelectorOption<bool>>[
                    OptionsSelectorOption<bool>(
                      title: 'Entry',
                      value: true,
                    ),
                    OptionsSelectorOption<bool>(
                      title: 'Exit',
                      value: false,
                    ),
                  ],
                  onSelect: (List<bool> selected) => entity.entry = selected[0],
                ),

                /// --> Load Type Selection.
                //TODO: add logic to get catalogues.

                /// -->
                SectionWidget(
                  title: 'Drivers',
                  outterPadding: EdgeInsets.zero,
                  child: SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
