
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
    return Column(
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
              EntityFinderSelector<Manufacturer, ManufacturersServiceI>(
                label: '*Manufacturer',
                initialValue: itemState?.entity.internal?.model.manufacturer,
                textBuilder: (Manufacturer manufacturer) => manufacturer.name,
                entityBuilder: () => Manufacturer(),
                onSelected: (Manufacturer? manufacturer) {
                  VehiculeModel? model =  itemState?.entity.internal?.model;
                  if (model!.id != BigInt.zero) model = VehiculeModel();
                  model = model.sanitize(manufacturer: manufacturer ?? Manufacturer());
                  itemState?.react();
                },
              ),
              TextInput(
                label: '*name',
                maxLength: 100,
                controller: TextEditingController(text: itemState?.entity.internal?.model.name ?? ''),
                onChanged: (String value){
                  VehiculeModel? model =  itemState?.entity.internal?.model;
                  if (model!.id != BigInt.zero) model = VehiculeModel();
                  model = model.sanitize(name: value);
                  model?.status = _defaultStatus;
                  itemState?.react();
                },
              ),
              TextInput(
                label: 'Description',
                maxLength: 200,
                controller: TextEditingController(text: itemState?.entity.internal?.model.description ?? ''),
                onChanged: (String value) {
                  VehiculeModel? model =  itemState?.entity.internal?.model;
                  if (model!.id != BigInt.zero) model = VehiculeModel();
                  model = model.sanitize(description: value);
                  model?.status = _defaultStatus;
                  itemState?.react();
                } 
              ),
              Datepicker(
                width: double.maxFinite,
                label: 'Model Year',
                isDisabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.model.year.dateOnly,
                ),
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  VehiculeModel? model =  itemState?.entity.internal?.model;
                  if (model!.id != BigInt.zero) model = VehiculeModel();
                  model = model.sanitize(
                    year: DateTime.tryParse(date ?? "") ?? DateTime(0),
                  );
                  model?.status = _defaultStatus;
                  itemState?.react();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}