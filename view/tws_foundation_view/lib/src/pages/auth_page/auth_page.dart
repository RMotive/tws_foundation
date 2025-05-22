import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/widgets/tws_display_flat.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_auth_page_form.dart';
part '_auth_page_form_reactor.dart';
part '_auth_page_business_logo.dart';

/// {page} implementation.
///
/// Defines an authentication entry point for {TWS} view solutions.
final class AuthPage extends PageB {
  /// Creates a new [AuthPage] instance.
  const AuthPage({super.key});

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    const double maxWidthAllowedFullView = 740;
    const double separatorDecoratorWidth = 1.5;
    const double itemSeparation = 20;
    const double rowSize = 400;
    const double separatorHeight = rowSize * .55;
    const double offsetTransaltionAboveCenterForm = 100;
    const double maxHeightAllowedToTranslateForm = 850;
    final Size screenSize = MediaQuery.sizeOf(buildContext);
    final double screenWidth = screenSize.width;

    final bool isFullView = screenWidth >= maxWidthAllowedFullView;
    final double translation =
        screenSize.height <= maxHeightAllowedToTranslateForm
            ? 0
            : -offsetTransaltionAboveCenterForm;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: translation),
        duration: 600.miliseconds,
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: Center(
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    runSpacing: itemSeparation * 2,
                    alignment:
                        isFullView
                            ? WrapAlignment.spaceEvenly
                            : WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      // --> Business decorator.
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              isFullView
                                  ? 0
                                  : (itemSeparation + separatorDecoratorWidth),
                        ),
                        child: const FittedBox(child: _AuthPageBusinessLogo()),
                      ),
                      // --> Separator bar.
                      Visibility(
                        visible: isFullView,
                        child: ColoredBox(
                          color: Colors.grey,
                          child: SizedBox.fromSize(
                            size: Size(
                              separatorDecoratorWidth,
                              separatorHeight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              isFullView
                                  ? 0
                                  : (itemSeparation + separatorDecoratorWidth),
                        ),
                        child: const _AuthPageForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
