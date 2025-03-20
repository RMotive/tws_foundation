import 'package:csm_view/csm_view.dart';
import 'package:example/core/landing_view/landing_view.dart';
import 'package:flutter/material.dart';

class LandingViewPage extends CSMPageBase {
  const LandingViewPage({super.key});

  @override
  Widget compose(BuildContext ctx, Size window) {
    return LandingView();
  }

}