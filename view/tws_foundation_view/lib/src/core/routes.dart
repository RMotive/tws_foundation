import 'package:csm_view/csm_view.dart';

/// {constant} class.
///
/// Stores {foundation} handled routes for {foundation view} configurations.
final class FoundationRoutes {
  /// (Login Page) Default [FoundationSecureView] route where the user must authenticate.
  static const Route authRoute = Route(
    '',
    name: 'Login Page',
  );

  //! --> Employee Routes

  /// (Employees Entity Page) route.
  static const Route employeesPageRoute = Route(
    'employees',
    name: 'Employees Page',
  );

  /// (Employees Create Whisper) route.
  static const Route employeesCreateWhisperRoute = Route(
    'create-employees',
    name: 'Employees Creation',
  );

  //! <-- Employee Routes

  //! --> YardLogs Routes

  /// (YardLogs Entity Page) route.
  static const Route yardlogsPageRoute = Route(
    'yardlogs',
    name: 'YardLogs Page',
  );

  /// (YardLogs Create Whisper) route.
  static const Route yardlogsCreateWhisperRoute = Route(
    'create-yardlogs',
    name: 'YardLogs Creation',
  );

  //! <--- YardLogs Routes

  //! --> Drivers Routes

  static const Route driversPageRoute = Route(
    'drivers',
    name: 'Drivers Page',
  );

  static const Route driversCreateWhisperRoute = Route(
    'create-drivers',
    name: 'Drivers Creation',
  );

  //! <-- Drivers Routes

  //! --> Trucks Routes

  static const Route trucksPageRoute = Route(
    'trucks',
    name: 'Trucks Page',
  );

  static const Route trucksCreateWhisperRoute = Route(
    'create-trucks',
    name: 'Trucks Creation',
  );
  
  //! <-- Trucks Routes

  //! --> Trailers Routes

  static const Route trailersPageRoute = Route(
    'trailers',
    name: 'Trailers Page',
  );

  static const Route trailersCreateWhisperRoute = Route(
    'create-trailers',
    name: 'Trailers Creation',
  );
  
  //! <-- Trailers Routes

  //! --> Locations Routes
  static const Route locationsPageRoute = Route(
    'locations',
    name: 'Locations Page',
  );

  static const Route locationsCreateWhisperRoute = Route(
    'create-locations',
    name: 'Locations Creation',
  );
  //! <-- Locations Routes

  //! --> Sections Routes
  static const Route sectionsPageRoute = Route(
    'sections',
    name: 'Sections Page',
  );

  static const Route sectionsCreateWhisperRoute = Route(
    'create-sections',
    name: 'Sections Creation',
  );
  //! <-- Sections Routes

  //! --> Accounts Routes
  static const Route accountsPageRoute = Route(
    'accounts',
    name: 'Accounts Page',
  );

  static const Route accountsCreateWhisperRoute = Route(
    'create-accounts',
    name: 'Accounts Creation',
  );
  //! <-- Accounts Routes

  //! --> Contacts Routes
  static const Route contactsPageRoute = Route(
    'contacts',
    name: 'Contacts Page',
  );

  static const Route contactsCreateWhisperRoute = Route(
    'create-contacts',
    name: 'Contacts Creation',
  );
  //! <-- Contacts Routes

  //! --> Permits Routes
  static const Route permitsPageRoute = Route(
    'permits',
    name: 'Permits Page',
  );

  static const Route permitsCreateWhisperRoute = Route(
    'create-permits',
    name: 'Permits Creation',
  );
  //! <-- Permits Routes

  //! --> Profiles Routes
  static const Route profilesPageRoute = Route(
    'profiles',
    name: 'Profiles Page',
  );

  static const Route profilesCreateWhisperRoute = Route(
    'create-profiles',
    name: 'Profiles Creation',
  );
  //! <-- Profiles Routes

  //! --> Solutions Routes
  static const Route solutionsPageRoute = Route(
    'solutions',
    name: 'Solutions Page',
  );

  static const Route solutionsCreateWhisperRoute = Route(
    'create-solutions',
    name: 'Solutions Creation',
  );
  //! <-- Solutions Routes


  //! --> Trailer Inventory Routes
  static const Route trailerInventoryPageRoute = Route(
    'trailers-inventory',
    name: 'Trailer Inventory Page',
  );

  //! <-- Trailer Inventory Routes

  
}