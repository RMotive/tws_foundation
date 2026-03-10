import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/profiles/profiles_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [ProfilesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class ProfilesCategoryPage extends EntityCategoryPageB<Profile, ProfilesEntityTableAdapter> {
  /// Creates a new [ProfilesCategoryPage] instance.
  ProfilesCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Profiles',
         routeData: FoundationRoutes.profilesPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.profilesCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => ProfilesPageCreateWhisper(),

      ),
    ];
  }

  @override
  ProfilesEntityTableAdapter composeAdapter() {
    return ProfilesEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(ProfilesEntityTableAdapter adapter) {
     return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.profilesCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.switch_account,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return ProfilesPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Profile] business entity to interact and manage data related with it.
final class ProfilesPage extends EntityViewPageBase<Profile, ProfilesEntityTableAdapter> {
  /// Creates a new [ProfilesPage] instance.
  ProfilesPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ProfilesEntityTable(
      adapter: adapter,
    );
  }
}
