part of 'create_yardlogs_whisper.dart';

/// State manager for Section fields.
class _SectionState extends ReactorBase {}
_SectionState _sectionState = _SectionState();
void Function() _sectionReact = () {};

/// Draws and handles the content for [CreateYardLogsWhisper], drawing each necessary
/// section and gathering required information to correctly create [YardLog] entities.
final class _CreateYardLogsWhisperContent extends StatefulWidget {
  
  /// Creation {event} controller.
  final CreateEntityFormController controller;

  /// Create a new [_CreateYardLogsWhisperContent] instance.
  const _CreateYardLogsWhisperContent({
    required this.controller,
  });

  @override
  State<_CreateYardLogsWhisperContent> createState() => _CreateYardLogsWhisperContentState();
}

/// Handles [State] for [_CreateYardLogsWhisperContent].
final class _CreateYardLogsWhisperContentState extends State<_CreateYardLogsWhisperContent> {

  /// {state} Instance of the current ThemingUtils.
  late FoundationThemeB theme;

  /// {state} stores the last [_getUserData] invokation.
  late final Future<Employee?> _getUserEmployeeInstance = _getUserData();
  
  /// {state} stores the default entity status.
  late final Status? defStatus;

  /// {state} guard who's creating the yardlog(s).
  late final Employee? guard;

  @override
  void didChangeDependencies() {
    theme = ThemingUtils.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<Employee?> _getUserData() async {
    SessionStorageI sessionStorage = InjectorUtils.get();
    EmployeesServiceI employeesService = InjectorUtils.get();
    StatusesServiceI statusService = InjectorUtils.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

    FoundationResponseResolver<Status?> statusResponseResolver = await statusService.read(FoundationReferences.statusActive,token);

    defStatus = statusResponseResolver.resolveDirect(() => Status());

    guard = responseResolver.resolveDirect(
      () => Employee(),
    );

    return guard;
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

        return CreateEntityForm<YardLog, YardLogsServiceI>(
          isMultiple: false,
          controller: widget.controller,
          factory: () {
            YardLog log = YardLog();
            log.guard = guard!;
            return log;
          },
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          formDesigner: (CreateEntityFormRecordReactor<YardLog>? itemState, ScrollController scrollController) {
            return YardlogWhisperFormDesigner(
              theme: theme,
              itemState: itemState,
              isReservation: false,
              availableVendors: <Vendor>[],
            );
          },
        );
      },
    );
  }
}
