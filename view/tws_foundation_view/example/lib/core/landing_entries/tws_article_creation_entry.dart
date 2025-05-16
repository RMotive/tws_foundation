
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase> twsArticleCreationEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Article Creation", 
      description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "Manage the creation and submit of generic [TModel] items",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    TWSArticleCreatorAgent<TrailerClass> agent = TWSArticleCreatorAgent<TrailerClass>();
    return ColoredBox(
      color: theme.page.back,
      child: Column(
        spacing: 10,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: TWSArticleCreator<TrailerClass>(
              factory:() => TrailerClass.factory(""),
              agent: agent,
              onCreate: (List<TrailerClass> records) {
                print('executing OnCreate...');
                return <TWSArticleCreatorFeedback>[];
              },
              modelValidator: (TrailerClass model) {
                return model.evaluate().isEmpty;
              },
              itemDesigner:(TrailerClass actualModel, bool selected, bool valid) {
                return TWSArticleCreationStackItem(
                  properties: <TwsArticleCreationStackItemProperty>[
                    TwsArticleCreationStackItemProperty(
                      label: "Name",
                      maxWidth: 100, 
                      value: actualModel.name,
                    ),
                    TwsArticleCreationStackItemProperty(
                      label: "Description", 
                      maxWidth: 100,
                      value: actualModel.description ?? '---',
                    ),
                  ], 
                  selected: selected
                );
              },
              formDesigner:(TWSArticleCreatorItemState<TrailerClass>? itemState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    children: <Widget>[
                      TWSInputText(
                        label: "Name",
                        isEnabled: itemState != null,
                        isOptional: true,
                        controller: TextEditingController(text: itemState?.model.name),
                        onChanged:(String text) {
                          itemState?.model.name = text;
                          itemState?.updateModelRedrawing(
                            itemState.model
                          );
                        },
                      ),
                      TWSInputText(
                        label: "Description",
                        isOptional: true,
                        isEnabled: itemState != null,
                        controller: TextEditingController(text: itemState?.model.description),
                        onChanged:(String text) {
                          itemState?.model.description = text;
                          itemState?.updateModelRedrawing(
                            itemState.model
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: TWSButtonFlat(
              height: 50,
              label: 'Create',
              onTap:() {
                print('calling agent....');
                agent.create();
              },
            )
          ),
        ],
      ),
    );
  }
);

