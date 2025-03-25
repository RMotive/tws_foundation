part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsArticleCreationEntry = CSMPackageLandingEntry(
  name: "TWS Article Creation", 
  description: RichText(
    text: TextSpan(
      text:
          "Manage the creation and submit of generic [TModel] items",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    TWSFThemeBase theme = getTheme<TWSFThemeBase>();
    TWSArticleCreatorAgent<Feature> agent = TWSArticleCreatorAgent<Feature>();
    return ColoredBox(
      color: theme.page.main,
      child: CSMSpacingColumn(
        spacing: 10,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: TWSArticleCreator<Feature>(
              factory:() => Feature(0, "", null),
              agent: agent,
              onCreate: (List<Feature> records) {
                print('executing OnCreate...');
                return <TWSArticleCreatorFeedback>[];
              },
              modelValidator: (Feature model) {
                return model.evaluate().isEmpty;
              },
              itemDesigner:(Feature actualModel, bool selected, bool valid) {
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
              formDesigner:(TWSArticleCreatorItemState<Feature>? itemState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CSMSpacingColumn(
                    spacing: 10,
                    children: <Widget>[
                      TWSInputText(
                        label: "Name",
                        isEnabled: itemState != null,
                        isOptional: true,
                        controller: TextEditingController(text: itemState?.model.name),
                        onChanged:(String text) {
                          itemState?.updateModelRedrawing(
                            itemState.model.clone(
                              name: text,
                            ),
                          );
                        },
                      ),
                      TWSInputText(
                        label: "Description",
                        isOptional: true,
                        isEnabled: itemState != null,
                        controller: TextEditingController(text: itemState?.model.description),
                        onChanged:(String text) {
                          itemState?.updateModelRedrawing(
                            itemState.model.clone(
                              description: text,
                            ),
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

