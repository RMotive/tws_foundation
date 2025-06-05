import 'dart:convert';
import 'dart:typed_data';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/button_flat.dart';
import 'package:tws_foundation_view/src/widgets/tws_file_picker.dart';
part 'tws_photo_taker_photo_preview.dart';
part 'tws_photo_taker_camera.dart';

/// Initialize an [CameraPlatform] object to access to the device camera functions.
final CameraPlatform _cameraPlatform = CameraPlatform.instance;

/// Logs advisor intializing.
const Console _advisor = Console('TWSPhotoTaker');

/// [TWSPhotoTaker] This component can access to the device camera and picture storage to take photos or select stores images.
///
/// This widget can:
///   - Take photos using devices with camera capabilities (mobile or PC).
///   - Select and load any image file in local storage (mobile or PC).
final class TWSPhotoTaker extends StatefulWidget {
  /// Preload an image on widget load.
  final XFile? preLoad;

  /// Trigger method on take a photo.
  final void Function(XFile photo)? onPhotoTaken;

  /// Disable controls component.
  final bool disabled;

  /// Title text.
  final String label;

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

  /// Enabled the cancel current image loaded.
  ///
  /// Ideal when is updating some records and want to delete the preloaded image.
  final bool cancelButtonEnable;

  const TWSPhotoTaker({
    super.key,
    this.preLoad,
    this.onPhotoTaken,
    this.preLoadBase64,
    this.disabled = false,
    this.label = 'Tomar foto',
    this.showFilePicker = true,
    this.cancelButtonEnable = true,
    this.onCancel,
  });

  @override
  State<TWSPhotoTaker> createState() => _TWSPhotoTakerState();
}

class _TWSPhotoTakerState extends State<TWSPhotoTaker> {
  /// Theme Manager injector.
  final ThemeManagerI<FoundationThemeB> themeManager = Injector.get();

  late FoundationThemeB theme;

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  bool _loadingCamera = true;

  XFile? _photo;
  CameraDescription? _cameraDefinition;
  List<CameraDescription> _cameras = <CameraDescription>[];
  Uint8List? originalImg;

  @override
  void didUpdateWidget(covariant TWSPhotoTaker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.preLoad == null) {
      _photo = null;
    }
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
  void initState() {
    super.initState();
    themeManager.addEffect(ref, themeUpdateListener);
    theme = themeManager.get();
    if (widget.preLoadBase64 != null) {
      originalImg = base64.decode(widget.preLoadBase64!);
    }
    getCameras();
  }

  @override
  void dispose() {
    themeManager.removeEffect(ref);
    super.dispose();
  }

  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      this.theme = theme;
    });
  }

  void _openCameraDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _TWSPhotoTakerPhotoCamera(
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
        if (widget.showFilePicker)
          TwsFilePicker(
            dialogTitle: "Select a picture",
            fileType: FileType.image,
            cancelEnable:
                (_photo != null || widget.preLoadBase64 != null) &&
                widget.cancelButtonEnable,
            onSelect: (List<XFile> xFiles, List<PlatformFile> files) {
              setState(() {
                _photo = xFiles.first;
                widget.onPhotoTaken?.call(xFiles.first);
              });
            },
            onCancel: () {
              setState(() {
                _photo = null;
                widget.onCancel?.call();
              });
            },
          ),
        ButtonFlat(
          disabled: _loadingCamera || _cameras.isEmpty || widget.disabled,
          label:
              _loadingCamera
                  ? 'Obteniendo información de las cámaras'
                  : _cameras.isNotEmpty
                  ? widget.label
                  : 'No hay cámaras disponibles',
          onTap: _openCameraDialog,
        ),
        Row(
          spacing: 12,
          children: <Widget>[
            Visibility(
              visible: widget.preLoadBase64 == null && _photo == null,
              replacement: PointerArea(
                cursor: SystemMouseCursors.click,
                onClick: () {
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext context) => _TWSPhotoTakerPhotoPreview(
                          file: _photo,
                          originalBytes: originalImg,
                        ),
                  );
                },
                child:
                    _photo == null && originalImg != null
                        ? SizedBox(
                          width: 48,
                          height: 48,
                          child: Image.memory(originalImg!),
                        )
                        : Image.network(
                          _photo?.path ?? '',
                          width: 48,
                          height: 48,
                        ),
              ),
              child: Icon(Icons.photo, size: 48, color: theme.page.fore),
            ),
            Text(
              style: TextStyle(color: theme.page.fore),
              _photo == null && widget.preLoadBase64 == null
                  ? 'Vacío'
                  : 'Foto guardada',
            ),
          ],
        ),
      ],
    );
  }
}
