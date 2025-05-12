part of 'tws_autocomplete_field.dart';

class _TWSAutocompleteFuture<T> extends StatelessWidget {
  final Future<List<SetViewOutput<dynamic>>> Function() consume;
  final ScrollController controller;
  final double tileHeigth;
  final SimpleTheming theme;
  final String Function(T?) displayLabel;
  final String Function(T?)? suffixLabel;
  final void Function(String label, T? item) onTap;
  final void Function(List<SetViewOutput<dynamic>> data, _TWSAutoCompleteFieldFutureState<T> state) onFetch;
  final Color loadingColor;
  final Color hoverTextColor;
  final AsyncWidgetController agent;
  final _TWSAutoCompleteFieldFutureState<T> state;

  const _TWSAutocompleteFuture({
    required this.consume,
    required this.controller,
    required this.displayLabel,
    required this.theme,
    required this.onTap,
    required this.loadingColor,
    required this.hoverTextColor,
    required this.onFetch,
    required this.tileHeigth,
    required this.agent,
    required this.state,
    this.suffixLabel
  });

  List<T> getSets(List<SetViewOutput<dynamic>> rawData) {
    List<T> data = <T>[];
    for (SetViewOutput<dynamic> view in rawData) {
      data = <T>[...data, ...view.records];
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<List<SetViewOutput<dynamic>>>(
      future: consume,
      agent: agent,
      emptyCheck: (List<SetViewOutput<dynamic>> data) {
        onFetch(data, state); 
        int cont = 0;
        for(SetViewOutput<dynamic> view in data){
          cont += view.records.length;
        }
        return cont == 0? true: false;
      },
      loadingBuilder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: CircularProgressIndicator(
            backgroundColor: TWSFColors.darkGrey,
            color: loadingColor,
            strokeWidth: 4,
          ),
        );
      },
      errorBuilder: (BuildContext ctx, Object? error, List<SetViewOutput<dynamic>>? data) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: TWSDisplayFlat(
            display: error == null? 'No hay resultados' : "Problema al cargar",
          ),
        );
      },
      successBuilder: (BuildContext ctx, List<SetViewOutput<dynamic>> rawData) {     
        return Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          controller: controller,
          child: ReactiveWidget<_TWSAutoCompleteFieldFutureState<T>>(
            reactor: _TWSAutoCompleteFieldFutureState<T>(), 
            builder:(BuildContext ctx, _TWSAutoCompleteFieldFutureState<T> state) {
              onFetch(rawData, state);
              List<T> data = state.preloadedItems;
              if(data.isEmpty){
                data = getSets(rawData);
              }  
              return _TWSAutocompleteList<T>(
                controller: controller,
                list: data ,
                suffixLabel: suffixLabel,
                displayLabel: displayLabel,
                theme: theme,
                hoverTextColor: hoverTextColor,
                onTap: onTap,
              );
            },
          ),
        );
      },
    );
  }
}