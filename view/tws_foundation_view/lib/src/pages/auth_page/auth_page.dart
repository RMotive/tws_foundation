import 'dart:async' show FutureOr;

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/tws_display_flat.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_auth_page_form.dart';
part '_auth_page_business_logo.dart';

/// {page} implementation.
///
/// Defines an authentication entry point for {TWS} view solutions.
final class AuthPage extends PageB {
  /// Solution authentication scope sign identification.
  final String solutionSign;

  /// Callback when the [AuthPage] correctly authenticates the user information.
  ///
  ///
  /// [serverSession] server session information from the given credentials.
  final FutureOr<void> Function(ServerSession serverSession) onAuthSuccess;

  /// Creates a new [AuthPage] instance.
  const AuthPage({super.key, required this.solutionSign, required this.onAuthSuccess});

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    const double maxWidthAllowedFullView = 740;
    const double separatorDecoratorWidth = 1.5;
    const double itemSeparation = 20;
    const double rowSize = 400;
    const double separatorHeight = rowSize * .55;
    const double offsetTransaltionAboveCenterForm = 100;
    const double maxHeightAllowedToTranslateForm = 850;

    final bool isFullView = pageSize.width >= maxWidthAllowedFullView;
    final double translation =
        pageSize.height <= maxHeightAllowedToTranslateForm ? 0 : -offsetTransaltionAboveCenterForm;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: translation),
              duration: 600.miliseconds,
              builder: (BuildContext context, double value, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: Center(
                    child: SizedBox(
                      width: pageSize.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          runSpacing: itemSeparation * 2,
                          alignment: isFullView ? WrapAlignment.spaceEvenly : WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            // --> Business decorator.
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isFullView ? 0 : (itemSeparation + separatorDecoratorWidth),
                              ),
                              child: FittedBox(child: _AuthPageBusinessLogo()),
                            ),
                            // --> Separator bar.
                            Visibility(
                              visible: isFullView,
                              child: ColoredBox(
                                color: Colors.grey,
                                child: SizedBox.fromSize(size: Size(separatorDecoratorWidth, separatorHeight)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isFullView ? 0 : (itemSeparation + separatorDecoratorWidth),
                              ),
                              child: _AuthPageForm(solutionSign: solutionSign, onAuthSuccess: onAuthSuccess),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Builder(
            builder: (BuildContext context) {
              final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

              return AnimatedSize(
                duration: 2.seconds,
                child: SizedBox(
                  width: pageSize.width,
                  height: keyboardInset,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
