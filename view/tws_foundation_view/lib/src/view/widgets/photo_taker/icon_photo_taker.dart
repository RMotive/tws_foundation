import 'dart:convert';
import 'dart:typed_data';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_svg/svg.dart';
import 'package:tws_foundation_view/src/core/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/view/widgets/file_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/photo_taker/photo_taker.dart';

/// Initialize an [CameraPlatform] object to access to the device camera functions.
final CameraPlatform _cameraPlatform = CameraPlatform.instance;

/// Logs advisor intializing.
const Console _advisor = Console('IconPhotoTaker');

/// [PhotoTaker] This component can access to the device camera and picture storage to take photos or select stores images.
///
/// This widget can:
///   - Take photos using devices with camera capabilities (mobile or PC).
///   - Select and load any image file in local storage (mobile or PC).
/// 
/// Supported extensions: .svg
final class IconPhotoTaker extends StatefulWidget {
  /// Height of the icon button.
  final double height;

  /// Path to the svg icon to use as button.
  final String resourceRoute;

  /// Preload an image on widget load.
  final XFile? preLoad;

  /// Trigger method on take a photo.
  final void Function(XFile photo)? onPhotoTaken;

  /// Disable controls component.
  final bool disabled;

  /// Display and aditional control button to select any image file stored in the device.
  final bool showFilePicker;

  /// Preload and base64 img.
  /// An alternative for [Preload] property if an [XFile] image is not available.
  ///
  /// This property is designed for manage state images while editing and updating records that not contain an [XFile] image.
  /// In this cases this property must contain the image data reference that is beign updated.
  ///
  /// See update whispers implementations.
  final String? preLoadBase64;

  /// Method to trigger when the cancel button is clicked or the file selection dialog is closed and it's empty.
  final void Function()? onCancel;

  /// Color to apply to the icon.
  final Color? iconColor;

  /// Enabled the cancel current image loaded.
  ///
  /// Ideal when is updating some records and want to delete the preloaded image.
  final bool cancelButtonEnable;

  const IconPhotoTaker({
    super.key,
    this.height = 250,
    this.preLoad,
    this.onPhotoTaken,
    this.preLoadBase64,
    this.disabled = false,
    this.showFilePicker = true,
    this.cancelButtonEnable = true,
    this.onCancel,
    this.iconColor,
    required this.resourceRoute,
  });

  @override
  State<IconPhotoTaker> createState() => _PhotoTakerState();
}

class _PhotoTakerState extends State<IconPhotoTaker> {
  /// Instance of the current theming.
  late FoundationThemeB theme;

  bool _loadingCamera = true;

  XFile? _photo;
  CameraDescription? _cameraDefinition;
  List<CameraDescription> _cameras = <CameraDescription>[];
  Uint8List? originalImg;

  @override
  void didUpdateWidget(covariant IconPhotoTaker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _photo = widget.preLoad;

  }


  void getCameras() {
    if (_cameras.isNotEmpty) {
      setState(() {
        _cameras = <CameraDescription>[];
      });
    }

    _cameraPlatform.availableCameras().then(
      (List<CameraDescription> camerasFound) {
        _cameras = camerasFound;
        CameraDescription cameraDescription = camerasFound.firstWhere(
          (CameraDescription i) => i.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras[0],
        );

        setState(() {
          _cameraDefinition = cameraDescription;
          _loadingCamera = false;
        });
      },
      onError: (Object ex, StackTrace t) {
        _advisor.exception('Camera Exception', Exception(ex), t);
        setState(() {
          _cameras = <CameraDescription>[];
          _loadingCamera = false;
        });
      },
    );
  }
  @override
  void didChangeDependencies() {
    theme = Theming.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();
    if (widget.preLoadBase64 != null) {
      originalImg = base64.decode(widget.preLoadBase64!);
    }
    getCameras();
  }

  void _openCameraDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoTakerPhotoCamera(
          camera: _cameraDefinition,
          onSave: (XFile file) {
            setState(() {
              _photo = file;
            });
            widget.onPhotoTaken?.call(file);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: <Widget>[
        PointerArea(
          cursor: SystemMouseCursors.click,
          onClick: () {
            _photo == null && originalImg == null
                ? _openCameraDialog()
                : showDialog(
                  context: context,
                  builder:
                      (BuildContext context) => PhotoTakerPhotoPreview(
                        file: _photo,
                        originalBytes: originalImg,
                      ),
                );
          },
          child: SizedBox(
            height: widget.height,
            width: double.maxFinite,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.fromBorderSide(
                  BorderSide(
                    width: 1,
                    color: theme.page.accent,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
              child: Visibility(
                visible: widget.preLoadBase64 == null && _photo == null,
                replacement: _photo == null && originalImg != null
                          ? FittedBox(
                            child: Image.memory(originalImg!),
                          )
                          : FittedBox(
                            child: Image.network(
                              _photo?.path ?? '',
                            ),
                          ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: theme.page.fore,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          widget.resourceRoute,
                          height: widget.height,
                          colorFilter: ColorFilter.mode(
                            widget.iconColor ?? theme.page.fore,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.showFilePicker)
          FileSelector(
            dialogTitle: "Select a picture",
            fileType: FileType.image,
            cancelEnable: (_photo != null || widget.preLoadBase64 != null) && widget.cancelButtonEnable,
            onSelect: (List<XFile> xFiles, List<PlatformFile> files) {
              setState(() {
                _photo = xFiles.first;
                widget.onPhotoTaken?.call(xFiles.first);
              });
            },
            onRemove: () {
              setState(() {
                _photo = null;
                widget.onCancel?.call();
              });
            },
          ),
      ],
    );
  }
}
