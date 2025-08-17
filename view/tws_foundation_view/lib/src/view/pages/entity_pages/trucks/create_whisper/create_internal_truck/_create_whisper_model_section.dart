
part of '../trucks_page_create_whisper.dart';
class _CreateWhisperModelSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TruckCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperModelSection({
    required this.itemState,
    required this.isEnabled,
  });
  
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Truck Model',
      child: Column(
        spacing: 10,
        children: <Widget>[
          EntityFinderSelector<VehiculeModel, VehiculeModelsServiceI>(
            label: '*Model',
            initialValue: itemState?.entity.internal?.model,
            textBuilder: (VehiculeModel model) => model.name,
            entityBuilder: () => VehiculeModel(),
            onSelected: (VehiculeModel? model) {
              itemState?.entity.internal?.model = model ?? VehiculeModel();
              itemState?.react();
            },
          ),

          FoldPanelWidget(
            title: "Add Model",
            child: Column(
              spacing: 10,
              children: <Widget>[
                const SectionDivider(text: 'Model Details'),

                EntityFinderSelector<Manufacturer, ManufacturerService>(
                  label: '*Manufacturer',
                  initialValue: itemState?.entity.internal?.model.manufacturer,
                  textBuilder: (Manufacturer manufacturer) => manufacturer.name,
                  entityBuilder: () => Manufacturer(),
                  onSelected: (Manufacturer? manufacturer) {
                    VehiculeModel? model =  itemState?.entity.internal?.model;
                    model = model?.sanitize(manufacturer: manufacturer ?? Manufacturer());
                    itemState?.react();
                  },
                ),

                TextInput(
                  label: '*name',
                  controller: TextEditingController(text: itemState?.entity.internal?.model.name ?? ''),
                  onChanged: (String value){
                    VehiculeModel? model =  itemState?.entity.internal?.model;
                    model = model?.sanitize()
                    itemState?.react();
                  },
                ),
                TextInput(
                  label: 'Description',
                  controller: TextEditingController(text: itemState?.entity.internal?.model.description ?? ''),
                  onChanged: (String value) {
                    VehiculeModel? model =  itemState?.entity.internal?.model;
                    model = model?.sanitize()
                    itemState?.react();
                  } 
                ),
                TextInput(
                  label: 'Model year',
                  controller: TextEditingController(text: itemState?.entity.internal?.model.year.toString() ?? ''),
                  onChanged: (String value) {
                    int? year = int.tryParse(value);
                    if (year != null) {
                      VehiculeModel? model =  itemState?.entity.internal?.model;
                      model = model?.sanitize(year:  DateTime.tryParse(value) ?? DateTime.now());
                      itemState?.react();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}