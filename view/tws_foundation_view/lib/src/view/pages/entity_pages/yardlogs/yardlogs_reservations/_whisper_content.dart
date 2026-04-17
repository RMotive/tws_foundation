part of 'create_yardlogs_reservations_whisper.dart';

/// Draws and handles the content for [CreateYardLogsWhisper], drawing each necessary
/// section and gathering required information to correctly create [YardLog] entities.
final class _CreateYardLogsReservationsWhisperContent extends StatefulWidget {

  /// Creation {event} controller.
  final CreateEntityFormController controller;
  
  /// Inner [YardLogsEntityTableAdapter] instance.
  final YardLogsEntityTableAdapter adapter;

  /// Create a new [_CreateYardLogsReservationsWhisperContent] instance.
  const _CreateYardLogsReservationsWhisperContent({
    required this.controller,
    required this.adapter,
  });

  @override
  State<_CreateYardLogsReservationsWhisperContent> createState() => _CreateYardLogsReservationsWhisperContentState();
}

/// Handles [State] for [_CreateYardLogsReservationsWhisperContent].
final class _CreateYardLogsReservationsWhisperContentState extends State<_CreateYardLogsReservationsWhisperContent> {

  /// {state} Instance of the current ThemingUtils.
  late FoundationThemeB theme;

  /// {state} stores the last [_getVendorsData] invokation.
  late final Future<ViewOutput<Vendor>> _getVendorInstance = _getVendorsData();
  
  /// {state} stores the default entity status.
  late final Status? defStatus;

  /// {state} guard who's creating the yardlog(s).
  late final ViewOutput<Vendor> vendors;

  @override
  void didChangeDependencies() {
    theme = ThemingUtils.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<ViewOutput<Vendor>> _getVendorsData() async {
    SessionStorageI sessionStorage = InjectorUtils.get();
    AccountServiceI accountsService = InjectorUtils.get();
    StatusesServiceI statusService = InjectorUtils.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<ViewOutput<Vendor>> responseResolver = await accountsService.getVendors(token);

    FoundationResponseResolver<Status?> statusResponseResolver = await statusService.read(FoundationReferences.statusActive,token);

    defStatus = statusResponseResolver.resolveDirect(() => Status());

    vendors = responseResolver.resolveDirect(
      () => ViewOutput<Vendor>(Vendor.new),
    );

    return vendors;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<ViewOutput<Vendor>>(
      future: _getVendorInstance,
      successBuilder: (BuildContext buildContext, ViewOutput<Vendor> data) {
        vendors = data;
        // TODO: define beheavior to show the "Only reservation" view.
        if (data.entities.isEmpty) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: ErrorMessageWidget(
                message: 'No vendors associated to the user, which is required to create a yardlog reservation.',
              ),
            ),
          );
        }

        return CreateEntityForm<YardLog, YardLogsServiceI>(
          isMultiple: false,
          controller: widget.controller,
          factory: () {
            // When creating a yardlog from a reservation, preload the reservation data at the form, otherwise create an empty yardlog.            
            YardLog log = widget.adapter.selectedReservation ?? YardLog();
            log.pending = false;
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
              isReservation: true,
              availableVendors: vendors.entities,
            );
          },
        );
      },
    );
  }
}
