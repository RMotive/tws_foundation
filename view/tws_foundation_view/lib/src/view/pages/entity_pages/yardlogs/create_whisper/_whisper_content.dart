part of 'create_yardlogs_whisper.dart';

/// Draws and handles the content for [CreateYardLogsWhisper], drawing each necessary
/// section and gathering required information to correctly create [YardLog] entities.
final class _CreateYardLogsWhisperContent extends StatefulWidget {
  /// Create a new [_CreateYardLogsWhisperContent] instance.
  const _CreateYardLogsWhisperContent();

  @override
  State<_CreateYardLogsWhisperContent> createState() => _CreateYardLogsWhisperContentState();
}

/// Handles [State] for [_CreateYardLogsWhisperContent].
final class _CreateYardLogsWhisperContentState extends State<_CreateYardLogsWhisperContent> {
  /// {state} stores the last [_getUserEmployee] invokation.
  late final Future<Employee?> _getUserEmployeeInstance = _getUserEmployee();

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<Employee?> _getUserEmployee() async {
    SessionStorageI sessionStorage = Injector.get();
    EmployeesServiceI employeesService = Injector.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

    return responseResolver.resolveDirect(
      () => Employee(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<Employee?>(
      future: _getUserEmployeeInstance,
      successBuilder: (BuildContext buildContext, Employee? data) {
        if (data == null) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: ErrorMessageWidget(
                message: 'You need to be an Employee to create YardLog(s)',
              ),
            ),
          );
        }

        return CreateEntityForm<YardLog>(
          isMultiple: false,
          entityFactory: () => YardLog(),
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
      },
    );
  }
}
