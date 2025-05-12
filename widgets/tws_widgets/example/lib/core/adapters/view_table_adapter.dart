import 'package:example/core/adapters/view_consume_adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

final class TableAdapter implements TWSArticleTableAdapter<TrailerClass> { 
  const TableAdapter();

  @override
  TWSArticleTableEditor? composeEditor(TrailerClass set, void Function() closeReinvoke, BuildContext context) {
    return TWSArticleTableEditor(
      form: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: <Widget>[
            TWSInputText(
              label: "Name",
              isStrictLength: false,
              controller: TextEditingController(
                text: set.name,
              ),
              onChanged: (String text) {
                // set.name = text;
                print(text);
              },
            ),
            TWSInputText(
              label: "Description",
              isStrictLength: false,
              controller: TextEditingController(
                text: set.description,
              ),
              onChanged: (String text) {
                // set = set.clone(
                //   description: text,
                // )
                print(text);
              },
            ),
          ],
        ),      
      ), 
      onCancel:closeReinvoke,
    );
  }

  @override
  Widget composeViewer(TrailerClass set, BuildContext context) {
    return SizedBox.expand(
      child: Column(
        spacing: 10,
        children: <Widget>[
          TWSPropertyViewer(
            label: 'Name',
            value: set.name,
          ),
          TWSPropertyViewer(
            label: 'Description',
            value: set.description ?? '---',
          ),
        ]
      ),
    );
  }

  @override
  Future<SetViewOutput<TrailerClass>> consume(int page, int range, List<SetViewOrderOptions> orderings) async {
    List<SetViewOutput<TrailerClass>> records = await ViewConsumeAdapter().consume(page, range, orderings, "");
    return records.first;
  }
  
  @override
  void onRemoveRequest(TrailerClass set, BuildContext context) {
    print('removing: ${set.name}');
  }

}
