import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/widgets/whisper.dart';

/// {whisper} class.
final class EmployeesPageCreateWhisper extends PageB {
  /// Creates a new [EmployeesPageCreateWhisper] instance.
  const EmployeesPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create Employee(s)',
    );
  }
}
