// ignore_for_file: directives_ordering

library;

//! --> [Core]

export 'src/core/typedefs.dart';

//! <-- [Core]

//! --> [Data]

export 'src/data/storages/session_storage.dart';

//! <-- [Data]

// [core]
export 'src/core/constants.dart';
export 'src/core/extensions.dart';

// [themes]
export 'src/core/themes/foundation_theme_b.dart';
export 'src/core/themes/foundation_theme_dark.dart';
export 'src/core/themes/foundation_theme_light.dart';


//! --> [Widgets]

//! --> Entity Tables

/// [Solutions Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/solutions_entity_table.dart';

/// [Yard Logs Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/yard_logs_entity_table.dart';

/// [Employees Entity Table]
export 'src/view/widgets/complex_widgets/foundation_entity_tables/employees_entity_table.dart';

//! <-- Entity Tables


// [widgets]
export 'src/view/widgets/dialog.dart';
export 'src/view/widgets/text_input.dart';
export 'src/view/widgets/button_flat.dart';
export 'src/view/widgets/complex_widgets/entity_table/entity_table.dart';
export 'src/view/widgets/complex_widgets/entity_table/entity_table_viewer.dart';
export 'src/view/widgets/complex_widgets/entity_table/entity_table_adapter_b.dart';
export 'src/view/widgets/complex_widgets/create_entity_form.dart/create_entity_form.dart';
export 'src/view/widgets/complex_widgets/create_entity_form.dart/create_entity_form_controller.dart';
export 'src/view/widgets/complex_widgets/create_entity_form.dart/create_entity_form_record.dart';
export 'src/view/widgets/complex_widgets/create_entity_form.dart/create_entity_form_record_reactor.dart';
export 'src/view/widgets/complex_widgets/create_entity_form.dart/create_entity_form_record_field.dart';
 
//! <-- [Widgets] 

//! --> Pages

/// [Auth Page]
export 'src/view/pages/auth_page/auth_page.dart';

//! --> Entity Pages

/// [YardLogs Page]
export 'src/view/pages/entity_pages/yardlogs/yardlogs_page.dart';

/// [Employees Page]
export 'src/view/pages/entity_pages/employees/employees_page.dart';

//! <-- Entity Pages

//! <-- Pages

// [layouts.category_layout]
export 'src/view/layouts/category_layout/category_layout.dart';
export 'src/view/layouts/category_layout/category_layout_page.dart';
export 'src/view/layouts/category_layout/_category_layout_ribbon/category_layout_ribbon_controller.dart';
export 'src/view/layouts/category_layout/_category_layout_ribbon/category_layout_ribbon_data_transfer_group_controller.dart';
export 'src/view/layouts/category_layout/_category_layout_ribbon/category_layout_ribbon_data_management_group_controller.dart';

// [layouts.navigation_layout]
export 'src/view/layouts/navigation_layout/navigation_layout.dart';
export 'src/view/layouts/navigation_layout/_navigation_layout_navigation/navigation_layout_entry.dart';
export 'src/view/layouts/navigation_layout/_navigation_layout_header/navigation_layout_header_user.dart';


