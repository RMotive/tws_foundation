import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Permit implements CSMSetInterface {
  
  /// [solution] Property key.
  static const String kSolution = "solution";

  /// [feature] Property key.
  static const String kFeature = "feature";

  /// [action] Property key.
  static const String kAction = "action";

  /// [reference] Property key.
  static const String kReference = "reference";

  /// [enable] Property key.
  static const String kEnable = "enable";

  /// [solutionNavigation] Property key.
  static const String kSolutionNavigation = "SolutionNavigation";

  /// [featureNavigation] Property key.
  static const String kFeatureNavigation = "FeatureNavigation";
  
  /// [actionNavigation] Property key.
  static const String kActionNavigation = "ActionNavigation";

  /// [AccountPermits] collection Property key.
  static const String kAccountPermits = "accountsPermits";

  /// [AccountProfiles] collection Property key.
  static const String kAccountProfiles = "accountsProfiles";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Creates an [Permit] object with default values.
  Permit.a();

  /// Database record pointer.
  @override
  int id = 0;

  /// Foreign relation [Solution] pointer.
  int solution = 0;

  /// Foreign relation [Feature] pointer.
  int feature = 0;
  
  /// Foreign relation [Action] pointer.
  int action = 0;
  
  /// Unique reference identifier.
  String reference = "";
  
  /// boolean validation status.
  bool enable = false;

  /// [Solution] Navigation set.
  Solution? solutionNavigation;

  /// [Feature] Navigation set.
  Feature? featureNavigation;

  /// [Action] Navigation set.
  Action? actionNavigation;
  
  List<Plate> plates = <Plate>[];

  /// Creates an [Identification] object based on required fields.
  Permit(
    this.id,
    this.solution,
    this.feature,
    this.action,
    this.reference,
    this.enable,
    this.solutionNavigation,
    this.featureNavigation,
    this.actionNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Identification] object based on a serealized JSON.
  factory Permit.des(JObject json) {
    int id = json.get(SCK.kId);
    int solution = json.get(kSolution);
    int feature = json.get(kFeature);
    int action = json.get(kAction);
    String reference = json.get(kReference);
    bool enable = json.get(kEnable);
    DateTime timestamp = json.get(SCK.kTimestamp);

    Solution? solutionNavigation;
    if (json[kSolutionNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSolutionNavigation, <String, dynamic>{});
      solutionNavigation = Solution.des(rawNavigation);
    }

    Feature? featureNavigation;
    if (json[kFeatureNavigation] != null) {
      JObject rawNavigation = json.getDefault(kFeatureNavigation, <String, dynamic>{});
      featureNavigation = Feature.des(rawNavigation);
    }

    Action? actionNavigation;
    if (json[kActionNavigation] != null) {
      JObject rawNavigation = json.getDefault(kActionNavigation, <String, dynamic>{});
      actionNavigation = Action.des(rawNavigation);
    }
        
    return Permit(id, solution, feature, action, reference, enable, solutionNavigation, featureNavigation, actionNavigation,timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kSolution: solution,
      kFeature: feature,
      kAction: action,
      kReference: reference,
      kEnable:enable,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kSolutionNavigation: solutionNavigation?.encode(),
      kFeatureNavigation: featureNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(reference.trim().isEmpty && reference.trim().length != 8) results.add(CSMSetValidationResult(kReference, '$kReference cannot be empty and must be 8 character length.', 'strictLength(8)'));
    if(solution < 0) results.add(CSMSetValidationResult(kSolution, '$kSolution pointer must be equal or greater than 0', 'pointerHandler()'));
    if(feature < 0) results.add(CSMSetValidationResult(kFeature, '$kFeature pointer must be equal or greater than 0', 'pointerHandler()'));
    if(action < 0) results.add(CSMSetValidationResult(kAction, '$kAction pointer must be equal or greater than 0', 'pointerHandler()'));

    if(solutionNavigation != null) results = <CSMSetValidationResult>[...results, ...solutionNavigation!.evaluate()];
    if(featureNavigation != null) results = <CSMSetValidationResult>[...results, ...featureNavigation!.evaluate()];
    if(actionNavigation != null) results = <CSMSetValidationResult>[...results, ...actionNavigation!.evaluate()];

    return results;
  }
  /// Creates an [Identification] overriding the given properties.
  Permit clone({
    int? id,
    int? solution,
    int? feature,
    int? action,
    String? reference,
    bool? enable,
    Solution? solutionNavigation,
    Feature? featureNavigation,
    Action? actionNavigation,
  }) {

    if (solution == 0) {
      this.solutionNavigation = null;
      solutionNavigation = null;
    }

    if (feature == 0) {
      this.featureNavigation = null;
      featureNavigation = null;
    }

    if (action == 0) {
      this.actionNavigation = null;
      actionNavigation = null;
    }
    
    return Permit(
      id ?? this.id,
      solution ?? this.solution,
      feature ?? this.feature,
      action ?? this.action,
      reference ?? this.reference,
      enable ?? this.enable,
      solutionNavigation ?? this.solutionNavigation,
      featureNavigation ?? this.featureNavigation,
      actionNavigation ?? this.actionNavigation,
    );
  }
}
