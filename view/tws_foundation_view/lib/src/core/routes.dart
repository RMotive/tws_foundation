import 'package:csm_view/csm_view.dart';

/// {constant} class.
///
/// Stores {foundation} handled routes for {foundation view} configurations.
final class FoundationRoutes {
  /// (Login Page) Default [FoundationSecureView] RouteData where the user must authenticate.
  static const RouteData authRoute = RouteData(
    '',
    name: 'Login Page',
  );

  //! --> Category Layout Routes
    /// (Security category layout) RouteData.
    static const RouteData securityCategoryRoute = RouteData(
      'security_category',
      name: 'Security Category Page',
    );
  //! <-- Category Layout Routes

  //! --> Employee Routes

  /// (Employees Entity Page) RouteData.
  static const RouteData employeesPageRoute = RouteData(
    'employees',
    name: 'Employees Page',
  );

  /// (Employees Create Whisper) RouteData.
  static const RouteData employeesCreateWhisperRoute = RouteData(
    'create-employees',
    name: 'Employees Creation',
  );

  //! <-- Employee Routes

  //! --> YardLogs Routes

  /// (YardLogs Entity Page) RouteData.
  static const RouteData yardlogsPageRoute = RouteData(
    'yardlogs',
    name: 'YardLogs Page',
  );

   /// (YardLogs Reservations Entity Page) RouteData.
  static const RouteData yardlogsReservationsPageRoute = RouteData(
    'yardlogs-reservations',
    name: 'YardLogs Reservations Page',
  );

  /// (YardLogs Create Whisper) RouteData.
  static const RouteData yardlogsCreateWhisperRoute = RouteData(
    'create-yardlogs',
    name: 'YardLogs Creation',
  );

   /// (YardLogs Create Whisper) RouteData.
  static const RouteData yardlogsReservationsCreateWhisperRoute = RouteData(
    'create-yardlogs-reservations',
    name: 'YardLogs Reservations Creation',
  );

  //! <--- YardLogs Routes

  //! --> Drivers Routes

  static const RouteData driversPageRoute = RouteData(
    'drivers',
    name: 'Drivers Page',
  );

  static const RouteData driversCreateWhisperRoute = RouteData(
    'create-drivers',
    name: 'Drivers Creation',
  );

  //! <-- Drivers Routes

  //! --> Trucks Routes

  static const RouteData trucksPageRoute = RouteData(
    'trucks',
    name: 'Trucks Page',
  );

  static const RouteData trucksCreateWhisperRoute = RouteData(
    'create-trucks',
    name: 'Trucks Creation',
  );
  
  //! <-- Trucks Routes

  //! --> Trailers Routes

  static const RouteData trailersPageRoute = RouteData(
    'trailers',
    name: 'Trailers Page',
  );

  static const RouteData trailersCreateWhisperRoute = RouteData(
    'create-trailers',
    name: 'Trailers Creation',
  );
  
  //! <-- Trailers Routes

  //! --> Locations Routes
  static const RouteData locationsPageRoute = RouteData(
    'locations',
    name: 'Locations Page',
  );

  static const RouteData locationsCreateWhisperRoute = RouteData(
    'create-locations',
    name: 'Locations Creation',
  );
  //! <-- Locations Routes

  //! --> Sections Routes
  static const RouteData sectionsPageRoute = RouteData(
    'sections',
    name: 'Sections Page',
  );

  static const RouteData sectionsCreateWhisperRoute = RouteData(
    'create-sections',
    name: 'Sections Creation',
  );
  //! <-- Sections Routes

  //! --> Accounts Routes
  static const RouteData accountsPageRoute = RouteData(
    'accounts',
    name: 'Accounts Page',
  );

  static const RouteData accountsCreateWhisperRoute = RouteData(
    'create-accounts',
    name: 'Accounts Creation',
  );
  //! <-- Accounts Routes

  //! --> Contacts Routes
  static const RouteData contactsPageRoute = RouteData(
    'contacts',
    name: 'Contacts Page',
  );

  static const RouteData contactsCreateWhisperRoute = RouteData(
    'create-contacts',
    name: 'Contacts Creation',
  );
  //! <-- Contacts Routes

  //! --> Permits Routes
  static const RouteData permitsPageRoute = RouteData(
    'permits',
    name: 'Permits Page',
  );

  static const RouteData permitsCreateWhisperRoute = RouteData(
    'create-permits',
    name: 'Permits Creation',
  );
  //! <-- Permits Routes

  //! --> Profiles Routes
  static const RouteData profilesPageRoute = RouteData(
    'profiles',
    name: 'Profiles Page',
  );

  static const RouteData profilesCreateWhisperRoute = RouteData(
    'create-profiles',
    name: 'Profiles Creation',
  );
  //! <-- Profiles Routes

  //! --> Solutions Routes
  static const RouteData solutionsPageRoute = RouteData(
    'solutions',
    name: 'Solutions Page',
  );

  static const RouteData solutionsCreateWhisperRoute = RouteData(
    'create-solutions',
    name: 'Solutions Creation',
  );
  //! <-- Solutions Routes


  //! --> Trailer Inventory Routes
  static const RouteData trailerInventoryPageRoute = RouteData(
    'trailers-inventory',
    name: 'Trailer Inventory Page',
  );

  //! <-- Trailer Inventory Routes

  
}