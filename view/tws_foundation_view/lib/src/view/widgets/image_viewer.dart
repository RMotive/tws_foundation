import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_svg/svg.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/data/const/resource_extensions.dart';
import 'package:tws_foundation_view/src/view/widgets/message_widgets/message_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Extensions suppoted by [Image] flutter class.
final Set<String> _imageExtensions = <String>{
  FoundationExtension.jpge,
  FoundationExtension.jpg,
  FoundationExtension.png,
  FoundationExtension.bmp,
  FoundationExtension.wbmp,
  FoundationExtension.gif,
};

/// [ImageViewer] Displays an image component, that expands the image on tap, based on the display or windows app dimensions.
class ImageViewer extends StatelessWidget {
  /// A resource entity for content display.
  /// 
  /// Suported formats: 
  final Resource resource;

  /// Component width.
  final double? width;

  /// Component height.
  final double? height;

  /// Image title.
  final String? title;

  /// Text style.
  final TextStyle style;

  /// Text alignment.
  final TextAlign align;

  /// SVG Color.
  final Color? svgColor;

  const ImageViewer({
    super.key,
    required this.resource,
    this.title,
    this.width,
    this.height,
    this.svgColor,
    this.style = const TextStyle(
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    this.align = TextAlign.center,
  });

  
  Widget _convertImage(bool isImage, bool isSVG, Color? svgColor){
    if(isImage) return Image.memory(filterQuality: FilterQuality.high, resource.file);
    if (isSVG) {
      return SvgPicture.memory(
        resource.file,
        colorFilter: ColorFilter.mode(
        svgColor ?? svgColor!,
        BlendMode.srcIn,
      ),
      );
    }
    
    return MessageWidget(text: 'Invalid image extension.');
  }
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    final bool isImage = _imageExtensions.contains(resource.extension.toLowerCase());
    final bool isSVG = resource.extension.toLowerCase() == FoundationExtension.svg;
    if(isSVG && svgColor == null) backgroundColor = Theming.get<FoundationThemeB>(context).page.back;

    void imageViewDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        PointerArea(
                          cursor: SystemMouseCursors.click,
                          onClick: () => Injector.get<Router>().pop(),
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 48,
                          ),
                        ),
                      ],
                    ),
                    _convertImage(isImage, isSVG, backgroundColor),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: <Widget>[
        if (title != null) Text(title!, textAlign: align, style: style),
        PointerArea(
          cursor: SystemMouseCursors.click,
          onClick: () => imageViewDialog(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width ?? double.maxFinite,
              maxHeight: height ?? double.maxFinite,
            ),
            child: _convertImage(isImage, isSVG, backgroundColor),
          ),
        ),
      ],
    );
  }
}
