part of '../trailers_page_create_whisper.dart';

/// Trailer type state class.
class _TypeState extends ReactorB {}

_TypeState _typeState = _TypeState();
// ignore: unused_element
void Function() _typeEffect = () {};

class _CreateWhisperTypeSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TrailerCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperTypeSection({
    required this.itemState,
    required this.isEnabled,
  });
  
  @override
  Widget build(BuildContext context) {
    return ReactiveWidget<_TypeState>(
      reactor: _typeState,
      builder: (BuildContext ctx, _TypeState reactor) {
        return Column(
          spacing: 10,
          children: <Widget>[
            EntityFinderSelector<TrailerType, TrailerTypesServiceI>(
              label: 'Select a Type',
              initialValue: itemState?.entity.type?.id != BigInt.zero ? itemState?.entity.type : null,
              textBuilder: (TrailerType type) => "${type.trailerClass.name} - ${type.size}",
              entityBuilder: () => TrailerType(),
              onSelected: (TrailerType? location) {
                itemState?.entity.type = location;
                itemState?.react();
              },
            ),
            FoldPanelWidget(
              title: 'Add Trailer type',
              child: Column(
                spacing: 10,
                children: <Widget>[
                  EntityFinderSelector<TrailerClass, TrailerClassesServiceI>(
                    label: 'Select a Class',
                    initialValue: itemState?.entity.type?.trailerClass,
                    enabled: itemState?.entity.type?.id != BigInt.zero || itemState?.entity.type == null,
                    textBuilder: (TrailerClass trailerClass) => trailerClass.name,
                    entityBuilder: () => TrailerClass(),
                    onSelected: (TrailerClass? trailerClass) {
                      itemState?.entity.type?.trailerClass = trailerClass ?? TrailerClass();
                      itemState?.react();
                    },
                  ),
                  TextInput(
                    label: "Size",
                    hint: "enter the plate identifier",
                    maxLength: 16,
                    isEnabled: itemState?.entity.type?.id == BigInt.zero || itemState?.entity.type == null,
                    controller: TextEditingController(
                      text: itemState?.entity.type?.size,
                    ),
                    onChanged: (String text) {
                      if (itemState?.entity.type != null && itemState?.entity.type?.id != BigInt.zero) {
                        itemState?.entity.type?.id = BigInt.zero;
                      }
                      itemState?.entity.type =
                          itemState?.entity.type != null
                              ? itemState?.entity.type?.sanitize(size: text)
                              : TrailerType().sanitize(size: text);
                      itemState?.react();

                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}