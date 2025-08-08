## 1.0.0

- Notes:
    1. Added [Example] dev environment.
    2. Added [TWSFThemeBase] class.
    3. Added the defaults [TWSFDarkTheme] and [TWSFLightTheme] for widgets.
    4. Added Routes system.
    5. Added [TWSFLandingFrame] wrap for Landing entries.
    6. Added [TWSFStateHolder] class for simple states initializations.
    7. [TWSCascadeSection] Now the cascade content is builded on demand, optimizing build time if the content is not visible.

    N. Added the following pages and creation [Whisper]'s:
        * [Employees]
        * [Drivers]
        * [Yardlogs]

    N. Added FutureOr callbacks on the following widgets:
        * [TWSButtonFlat]
        * [TWSCascadeSection]
        * [TWSConfirmationDialog]
        * [TWSDropup]
        * [TWSOptionsSelector]
        * [TWSSelectableList]
        * [TWSSwitchButton]

    N. Added the following models:
        * [TwsOptionSelectorAction]
        * [TWSArticleCreatorItemState]
        * [TWSArticleAgent]
        * [TWSArticleCreationItemState]
        * [TWSArticleCreatorFeedback]

    N. Added the following interfaces:
        * [TWSViewConsumeAdapter]
        * [TWSArticleTableAdapter]
        * [TWSArticleTableAgent]
        * [TWSArticleTableFieldOptions]
        
    N. Added the following view widgets: 
        * [TWSButtonFlat]
        * [TWSSection]
        * [TWSCascadeSection]
        * [TWSDatetimePicker]
        * [TWSConfirmationDialog]
        * [TWSDroup]
        * [TWSFilePicker]
        * [TWSFrameDecorations]
        * [TWSImageViewer]
        * [TWSIncrementalList]
        * [TWSInputText]
        * [TWSListTile]
        * [TWSOptionsSelector]
        * [TWSPagingSelector]
        * [TWSSectionDivider]
        * [TWSPropertyViewer]
        * [TWSSelectableList]
        * [TWSSwitchButton]
        * [TWSArticleCreator]
        * [TWSArticleTable]
        * [TWSAutocompleteField]
        * [TWSListViewer]
        * [TWSPhotoTaker]
        * [TWSFLoadingCircule] (Not exported. Only for internal use)
        * [InvalidatingDialog]
        * [ResumeDialog]

    N. Dependencies added:
        * flutter_web_plugins

        * go_router: ^14.0.2
        * file_picker: ^8.1.7
        * camera_platform_interface: ^2.8.0
        * camera_web: ^0.3.5

        * csm_view:
            git:
            url: https://github.com/RMotive/csm_view
            ref: main

        * tws_foundation_client:
            git:
            url: https://github.com/RMotive/tws_foundation
            path: client/tws_foundation_client
            ref: 60#61
        
- Fixes:

- Dependencies upgrade:

