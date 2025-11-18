part of '../trailers_page_create_whisper.dart';

class _CreateWhisperTrailersSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TrailerCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperTrailersSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        // --> Carrier Information
        EntityFinderSelector<Carrier, CarriersServiceI>(
          entityBuilder: () => Carrier(),
          label: '*Assing a carrier...',
          enabled:true,
          initialValue: itemState?.entity.internal?.carrier,
          textBuilder: (Carrier carrier) {
            return carrier.name;
          },
          onSelected: (Carrier? carrier) {
            itemState?.entity.internal?.carrier = carrier ?? Carrier();
            itemState?.react();
          },
        ),

        _CreateWhisperModelSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),

        _CreateWhisperTypeSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),
        
        // --> Plates Section
        SectionWidget(
          title: "Plates",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IncrementalList<Plate>(
              title: "Plates",
              modelBuilder:() => Plate(),
              recordLimit: 2,
              recordList: itemState?.entity.internal?.plates ?? <Plate>[], 
              onAdd: (Plate plate) {
                Trailer model = itemState!.entity.internal!;
                model.plates.add(plate);
                itemState!.react();
              },
              onRemove: () {
                Trailer model = itemState!.entity.internal!;
                model.plates.removeLast();
                itemState!.react();
              },
              recordBuilder:(Plate record, int index) {
                return _CreateWhisperPlatesSection(
                  index: index,
                  plate: record,
                  identifierOnChange:(String text) {
                    Trailer trailer = itemState!.entity.internal!;
                    trailer.plates[index].identifier = text;
                    trailer.plates[index].status = _defaultStatus;
                    itemState!.react();
                  },
                  countryOnChange:(String? text) {
                    Trailer trailer = itemState!.entity.internal!;
                    trailer.plates[index].country = text ?? '';
                    if(trailer.plates[index].country != text) trailer.plates[index].state = null;
                    trailer.plates[index].status = _defaultStatus;
                    itemState!.react();
                    
                    _plateEffect();
                  }, 
                  stateOnChange:(String? text) {
                    Trailer trailer = itemState!.entity.internal!;
                    trailer.plates[index].state = text;
                    trailer.plates[index].status = _defaultStatus;
                    itemState!.react();
                  }, 
                  expirationOnChange:(String text) {
                    Trailer trailer = itemState!.entity.internal!;
                    trailer.plates[index].expiration = DateTime.tryParse(text);
                    trailer.plates[index].status = _defaultStatus;
                    itemState!.react();
                  },
                );
              },
            ),
          ),
        ),

        _CreateWhisperSCTSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),

        _CreateWhisperMaintenanceSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),
      ],
    );
  }
}