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
            Expanded(
              child: TextInput(
                label: '*Vin',
                isEnabled: isEnabled,
                maxLength: 17,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.vin,
                ),
                onChanged: (String text) {
                  Truck truck = itemState!.entity.internal!;
                  truck.vin = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Motor',
                isEnabled: isEnabled,
                maxLength: 16,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.motor,
                ),
                onChanged: (String text) {
                  Truck truck = itemState!.entity.internal!;
                  truck.motor = text.cleaned;
                  itemState?.react();
                },
              ),
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
        
        // --> Plates Section
        SectionWidget(
          title: "Plates",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IncrementalList<Plate>(
              title: "Plates",
              modelBuilder:() => Plate(),
              recordLimit: 2,
              recordList: itemState!.entity.internal!.plates, 
              onAdd: (Plate plate) {
                Truck model = itemState!.entity.internal!;
                model.plates.add(plate);
                itemState!.react();
              },
              onRemove: () {
                Truck model = itemState!.entity.internal!;
                model.plates.removeLast();
                itemState!.react();
              },
              recordBuilder:(Plate record, int index) {
                return _CreateWhisperPlatesSection(
                  index: index,
                  plate: record,
                  identifierOnChange:(String text) {
                    Truck truck = itemState!.entity.internal!;
                    truck.plates[index].identifier = text;
                    truck.plates[index].status = _defaultStatus;
                    itemState!.react();
                  },
                  countryOnChange:(String? text) {
                    Truck truck = itemState!.entity.internal!;
                    truck.plates[index].country = text ?? '';
                    if(truck.plates[index].country != text) truck.plates[index].state = null;
                    truck.plates[index].status = _defaultStatus;
                    itemState!.react();
                    
                    _plateEffect();
                  }, 
                  stateOnChange:(String? text) {
                    Truck truck = itemState!.entity.internal!;
                    truck.plates[index].state = text;
                    truck.plates[index].status = _defaultStatus;
                    itemState!.react();
                  }, 
                  expirationOnChange:(String text) {
                    Truck truck = itemState!.entity.internal!;
                    truck.plates[index].expiration = DateTime.tryParse(text);
                    truck.plates[index].status = _defaultStatus;
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

        _CreateWhisperInsuranceSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),

        _CreateWhisperMaintenanceection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),
      ],
    );
  }
}