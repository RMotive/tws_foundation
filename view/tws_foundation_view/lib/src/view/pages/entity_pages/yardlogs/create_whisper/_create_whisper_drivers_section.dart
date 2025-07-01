part of 'yardlogs_page_create_whisper.dart';

/// {widget} {private} class.
///
///
final class _DriversSection extends StatefulWidget {
  const _DriversSection();

  @override
  State<_DriversSection> createState() => _DriversSectionState();
}

/// {state} class.
///
/// Handles [State] for [_DriversSection].
final class _DriversSectionState extends State<_DriversSection> {
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Drivers',
      outterPadding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        child: EntityFinderSelector<DriverCommon, DriversServiceI>(
          entityBuilder: () => DriverCommon(),
          label: 'Select a Driver...',
        ),
      ),
    );
  }
}
