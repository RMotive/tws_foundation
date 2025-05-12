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
    TWSFThemeBase theme = Injector.getTheme<TWSFThemeBase>();
    TWSArticleCreatorAgent<TrailerClass> agent = TWSArticleCreatorAgent<TrailerClass>();
    return ColoredBox(
      color: theme.page.main,
      child: Column(
        spacing: 10,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: TWSArticleCreator<TrailerClass>(
              factory:() => TrailerClass(0, "", null),
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

