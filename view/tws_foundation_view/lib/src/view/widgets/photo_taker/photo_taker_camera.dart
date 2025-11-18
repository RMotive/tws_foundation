part of 'photo_taker.dart';

///
final class PhotoTakerPhotoCamera extends StatefulWidget {
  ///
  final void Function(XFile) onSave;

  ///
  final CameraDescription? camera;

  ///
  const PhotoTakerPhotoCamera({
    super.key,
    required this.camera,
    required this.onSave,
  });

  @override
  State<PhotoTakerPhotoCamera> createState() =>
      _PhotoTakerPhotoCameraState();
}

class _PhotoTakerPhotoCameraState extends State<PhotoTakerPhotoCamera> {
  /// Instance of the current theming.
  late FoundationThemeB theme;

  ///
  int? _camera;

  ///
  XFile? _photo;

  ///
  bool initingCamera = true;

  ///
  CameraDescription? _cameraDefinition;

  ///
  Widget _composeSafePreview() {
    if (_camera == null) return const SizedBox();

    return _cameraPlatform.buildPreview(_camera!);
  }
  
  @override
  void didChangeDependencies() {
    theme = Theming.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }

  ///
  @override
  void initState() {
    super.initState();
    _cameraDefinition = widget.camera;
    if (_cameraDefinition != null) {
      _cameraPlatform
          .createCamera(_cameraDefinition!, ResolutionPreset.high)
          .then((int cameraId) {
            _cameraPlatform
                .initializeCamera(cameraId)
                .then((_) {
                  setState(() {
                    _camera = cameraId;
                    initingCamera = false;
                  });
                })
                .onError((Exception ex, StackTrace st) {
                  _advisor.exception('Unable to initialize camera', ex, st);
                  setState(() {
                    _camera = null;
                    initingCamera = false;
                  });
                });
          })
          .onError((Exception ex, StackTrace st) {
            _advisor.exception('Unable to create camera', ex, st);
            setState(() {
              _camera = null;
              initingCamera = false;
            });
          });
    }
  }

  ///
  @override
  void dispose() {
    if (_camera != null) {
      _cameraPlatform.dispose(_camera!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ColoredBox(
        color: theme.page.back,
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: (_camera == null || initingCamera),
              replacement: Visibility(
                visible: _photo == null,
                replacement: Image.network(
                  _photo?.path ?? '',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
                child: _composeSafePreview(),
              ),
              child: Center(
                child: Text(
                  initingCamera
                      ? 'Cargando cámara'
                      : 'No hay cámaras disponibles',
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.error.fore,
                    size: 32,
                  ),
                  onPressed: () {
                    Injector.get<Router>().pop();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      visible: _photo != null,
                      child: Row(
                        spacing: 8,
                        children: <Widget>[
                          ButtonFlat(
                            label: 'Guardar',
                            onClick: () {
                              widget.onSave(_photo!);
                              Injector.get<Router>().pop();
                            },
                          ),
                          ButtonFlat(
                            label: 'Retomar',
                            onClick: () {
                              setState(() {
                                _photo = null;
                              });

                              _cameraPlatform.resumePreview(_camera!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !(widget.camera == null || _photo != null),
                      child: IconButton(
                        enableFeedback: true,
                        color: theme.page.fore,
                        disabledColor: theme.control.back,
                        icon: const Icon(Icons.camera, size: 48),
                        onPressed: () {
                          if (_camera != null) {
                            _cameraPlatform.takePicture(_camera!).then((
                              XFile photo,
                            ) {
                              setState(() {
                                _photo = photo;
                              });
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
