import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/catalog_options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_create_whisper_truck_section.dart';
part '_create_whisper_driver_section.dart';
part '_create_whisper_trailer_section.dart';

/// {constant} default spacing between elements.
const double _kDefSpacing = 10;

/// {whisper} class.
final class YardLogsPageCreateWhisper extends PageB {
  /// Creates a new [YardLogsPageCreateWhisper] instance.
  const YardLogsPageCreateWhisper();

  Future<Employee> _getUserEmployee() async {
    SessionStorageI sessionStorage = Injector.get();
    EmployeesServiceI employeesService = Injector.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee> responseResolver = await employeesService.getUserEmployee(token);

    return responseResolver.resolveDirect(
      () => Employee(),
    );
  }

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create YardLog(s)',
      onPerform: () {},
      child: (GlobalKey<FormState> formState) {
        return AsyncWidget<Employee>(
          future: _getUserEmployee(),
          successBuilder: (BuildContext buildContext, Employee data) {
            return CreateEntityForm<YardLog>(
              entityFactory: () => YardLog(),
              isMultiple: false,
              formDesigner: (CreateEntityFormRecordReactor<YardLog>? itemState) {
                YardLog entity = itemState!.entity;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      spacing: 20,
                      children: <Widget>[
                        /// --> YardLog Entry
                        OptionsSelector<bool>(
                          height: 100,
                          fontSize: 30,
                          title: 'Event',
                          options: <OptionsSelectorOption<bool>>[
                            OptionsSelectorOption<bool>(
                              title: 'Entry',
                              value: true,
                            ),
                            OptionsSelectorOption<bool>(
                              title: 'Exit',
                              value: false,
                            ),
                          ],
                          onSelect: (List<bool> selected) => entity.entry = selected[0],
                        ),

                        /// --> Load Type Selection.
                        CatalogOptionsSelector<LoadType, LoadTypesServiceI>(
                          title: 'Load Type',
                          entityBuilder: () => LoadType(),
                          onSelect: (List<LoadType> selection) => entity.loadType = selection[0],
                        ),

                        /// --> Driver selection.
                        _DriversSection(
                          onSelection: (DriverCommon selDriver) => entity.driver = selDriver,
                        ),

                        /// --> Truck selection.
                        _TruckSection(
                          onSelection: (TruckCommon selTruck) => entity.truck = selTruck,
                        ),

                        /// --> Trailer selection.
                        _TrailerSection(
                          onSelection: (TrailerCommon selTrailer) => entity.trailer = selTrailer,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        );
      },
    );
  }
}

/// {widget} {private} class.
///
/// Simplifies [Wrap] draw giving default spacing values.
final class _SpacedWrap extends StatelessWidget {
  final List<Widget> children;

  const _SpacedWrap({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _kDefSpacing,
      runSpacing: _kDefSpacing,
      children: children,
    );
  }
}
