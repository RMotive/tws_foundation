import 'dart:typed_data';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
/// [TWSImageViewer] Displays an image component, that expands the image on tap, based on the display or windows app dimensions.
class TWSImageViewer extends StatelessWidget {
  ///A base64 string image converted to bits.
  final Uint8List img;

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

  const TWSImageViewer({
    super.key,
    required this.img,
    this.title,
    this.width,
    this.height,
    this.style = const TextStyle(
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    this.align = TextAlign.center
  });
  
  @override
  Widget build(BuildContext context) {
    void imageViewDialog(Uint8List img) {
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),  
                        ),
                        PointerArea(
                          cursor: SystemMouseCursors.click,
                          onClick: () => Injector.get<Router>().pop(),
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 48
                          ),
                        ),
                      ]
                    ),
                    Image.memory(
                      filterQuality: FilterQuality.high,  
                      img,
                    ),
                  ],
                ),
              ]
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: <Widget>[
        if(title != null)
        Text(
          title!,
          textAlign: align,
          style: style
        ),
        PointerArea(
          cursor: SystemMouseCursors.click,
          onClick: () => imageViewDialog(img),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width ?? double.maxFinite,
              maxHeight: height ?? double.maxFinite
            ),
            child: Image.memory(img)
          )
        ),
      ]
    );
  }
}