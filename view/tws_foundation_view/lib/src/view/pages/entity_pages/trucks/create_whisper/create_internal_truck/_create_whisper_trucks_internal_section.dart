part of '../trucks_page_create_whisper.dart';

class _EmployeeCreationState extends ReactorB { }
final _EmployeeCreationState _employeeState = _EmployeeCreationState();

class _CreateWhisperTrucksSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TruckCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperTrucksSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          spacing: 10,
          children: <Widget>[
            TextInput(
              label: '*Vin',
              isEnabled: isEnabled,
              maxLength: 18,
              controller: TextEditingController(
                text: itemState?.entity.internal?.vin,
              ),
              onChanged: (String text) {
                Truck truck = itemState!.entity.internal!;
                truck.vin = text;
                itemState?.react();
              },
            ),
            TextInput(
              label: 'Motor',
              isEnabled: isEnabled,
              maxLength: 12,
              controller: TextEditingController(
                text: itemState?.entity.internal?.motor,
              ),
              onChanged: (String text) {
                Truck truck = itemState!.entity.internal!;
                truck.motor = text.cleaned;
                itemState?.react();
              },
            ),
          ],
        ),

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

        // EntityFinderSelector<Manufacturer, ManufacturerService>(
        //         label: '*Manufacturer',
        //         initialValue: entity.internal?.model.manufacturer,
        //         textBuilder:(Manufacturer manufacturer) => manufacturer.name,
        //         entityBuilder: () => Manufacturer(),
        //         onSelected: (Manufacturer? manufacturer) {
        //           entity.internal?.model.manufacturer = manufacturer ?? Manufacturer();
        //         },
        //       ),


        //       TextInput(
        //         label: '*name',
        //         controller: TextEditingController(text: entity.internal?.model.name ?? ''),
        //         onChanged: (String value) => entity.internal?.model.name = value,
        //       ),
        //       TextInput(
        //         label: 'Description',
        //         controller: TextEditingController(text: entity.internal?.model.description ?? ''),
        //         onChanged: (String value) => entity.internal?.model.description = value,
        //       ),
        //       TextInput(
        //         label: 'Model year',
        //         controller: TextEditingController(text: entity.internal?.model.year.toString() ?? ''),
        //         onChanged: (String value) {
        //           int? year = int.tryParse(value);
        //           if (year != null) {
        //             entity.internal?.model.year = DateTime.tryParse(value) ?? DateTime.now();
        //           }
        //         },
        //       ),

        

       

        FoldPanelWidget(
          title: 'Add model',
          onChange: (bool visible) {
            if(entity.internal?.model.id == BigInt.zero) return;
            entity.internal?.model = VehiculeModel();
          },
          child: Column(
            spacing: 10,
            children: <Widget>[
              
            ],
          )
        )

      ],
    );
  }
}