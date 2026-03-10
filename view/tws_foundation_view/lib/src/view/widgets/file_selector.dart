import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// [FileSelector] Widget that shows a dialog (web or mobile) to select one or multiple specified extension files.
class FileSelector extends StatefulWidget {
  /// Title for the file picker dialog.
  final String dialogTitle;

  /// Specify the selectable file type.
  final FileType fileType;

  /// Specify the file extension allowed.
  final List<String>? allowedExtensions;

  /// Function to trigger on finishing file loading.
  final dynamic Function(FilePickerStatus)? onFileLoading;

  /// Function to trigger when the remove button is pressed.
  final void Function()? onRemove;

  /// Return the user file selection in both, [XFile] and [PlatformFile] format.
  final void Function(List<XFile> xFiles, List<PlatformFile> files) onSelect;

  /// Enabled the cancel current image loaded.
  ///
  /// Ideal when is updating some records and want to delete the preloaded image.
  ///
  /// This property es false by default.
  final bool cancelEnable;

  const FileSelector({
    super.key,
    required this.dialogTitle,
    required this.onSelect,
    this.fileType = FileType.any,
    this.cancelEnable = false,
    this.allowedExtensions,
    this.onFileLoading,
    this.onRemove,
  });

  @override
  State<FileSelector> createState() => _FileSelectorState();
}

class _FileSelectorState extends State<FileSelector> {
  // Lists to store the user selection.
  late List<XFile> selectedXfiles;
  late List<PlatformFile> selectedPlatformFiles;

  void clearStorage() {
    widget.onRemove?.call();
    setState(() {
      selectedPlatformFiles = <PlatformFile>[];
      selectedXfiles = <XFile>[];
    });
  }

  @override
  void initState() {
    selectedXfiles = <XFile>[];
    selectedPlatformFiles = <PlatformFile>[];
    super.initState();
  }

  void pickFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      dialogTitle: widget.dialogTitle,
      type: widget.fileType,
      allowedExtensions: widget.allowedExtensions,
      onFileLoading: widget.onFileLoading,
    );
    // On select files
    if (filePickerResult != null) {
      setState(() {
        selectedXfiles = filePickerResult.xFiles;
        selectedPlatformFiles = filePickerResult.files;
        widget.onSelect(selectedXfiles, selectedPlatformFiles);
      });
    } else {
      // When the user cancel the selection:
      if (mounted) {
        setState(() {
          widget.onRemove;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: ButtonFlat(
            label:
                selectedXfiles.isNotEmpty
                    ? selectedXfiles.first.name
                    : selectedPlatformFiles.isNotEmpty
                    ? selectedPlatformFiles.first.name
                    : "Select files",
            onClick: () => pickFile(),
          ),
        ),
        Expanded(
          child: ButtonFlat(
            label: "Remove",
            onClick: () => clearStorage(),
            disabled: (selectedXfiles.isEmpty || selectedPlatformFiles.isEmpty) && !widget.cancelEnable,
          ),
        ),
      ],
    );
  }
}
