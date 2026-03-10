// ignore_for_file: directives_ordering

library;

//! --> [Core]

export 'src/core/typedefs.dart';
export 'src/core/constants.dart';
export 'src/core/extensions.dart';
export 'src/core/routes.dart';

/// [Core.Themes]
export 'src/core/themes/foundation_theme_b.dart';
export 'src/core/themes/foundation_theme_dark.dart';
export 'src/core/themes/foundation_theme_light.dart';

//! <-- [Core]

//! --> [Data]

export 'src/data/storages/session_storage.dart';

//! <-- [Data]


//! --> [View]

//! --> [View.Layouts]

/// [View.Layouts.CategoryLayout]
export 'src/view/layouts/category_layout/category_layout_ribbon/actions_ribbon_generic_actions/actions_ribbon_export.dart';
//! <-- [View.Layouts]

//! <-- [View]


//! --> [Widgets]

export 'src/view/widgets/text_button.dart';
export 'src/view/widgets/fold_panel_widget.dart';

//! --> Entity Tables

/// [Solutions Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/solutions_entity_table.dart';

/// [Yard Logs Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/yard_logs_entity_table.dart';

/// [Employees Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/employees_entity_table.dart';

/// [Drivers Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/drivers_entity_table.dart';

/// [Trucks Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/trucks_entity_table.dart';

/// [Trailers Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/trailers_entity_table.dart';

/// [Location Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/locations_entity_table.dart';

/// [Sections Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/sections_entity_table.dart';

/// [Accounts Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/accounts_entity_table.dart';

/// [Contacts Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/contacts_entity_table.dart';

/// [Permits Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/permits_entity_table.dart';

/// [Profiles Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/profiles_entity_table.dart';

/// [Trailer inventory Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/trailers_inventory_entity_table.dart';

//! <-- Entity Tables

// [widgets]
export 'src/view/widgets/dialog_widgets/dialog.dart';
 
//! <-- [Widgets] 

//! --> Pages

/// [Auth Page]
export 'src/view/pages/auth_page/auth_page.dart';

//! --> Entity Pages

/// [YardLogs Page]
export 'src/view/pages/entity_pages/yardlogs/yardlogs_page.dart';

/// [Employees Page]
export 'src/view/pages/entity_pages/employees/employees_page.dart';

/// [Drivers Page]
export 'src/view/pages/entity_pages/drivers/drivers_page.dart';

/// [Trucks Page]
export 'src/view/pages/entity_pages/trucks/trucks_page.dart';

/// [Trailers Page]
export 'src/view/pages/entity_pages/trailers/trailers_page.dart';

/// [Locations Page]
export 'src/view/pages/entity_pages/locations/locations_page.dart';

/// [Sections Page]
export 'src/view/pages/entity_pages/sections/sections_page.dart';

/// [Accounts Page]
export 'src/view/pages/entity_pages/accounts/accounts_page.dart';

/// [Contacts Page]
export 'src/view/pages/entity_pages/contacts/contacts_page.dart';

/// [Permits Page]
export 'src/view/pages/entity_pages/permits/permits_page.dart';

/// [Profiles Page]
export 'src/view/pages/entity_pages/profiles/profiles_page.dart';

/// [Solutions Page]
export 'src/view/pages/entity_pages/solutions/solutions_page.dart';

/// [Trailer inventory Page]
export 'src/view/pages/entity_pages/inventories/trailer_inventory_page.dart';

//! <-- Entity Pages

