import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPopup extends StatefulWidget {
  final Function(List<PlatformFile>) onFilesSelected;

  UploadPopup({required this.onFilesSelected});

  @override
  _UploadPopupState createState() => _UploadPopupState();
}

class _UploadPopupState extends State<UploadPopup> {
  List<PlatformFile> selectedFiles = [];
  bool isUploading = false;

  Future<void> _selectFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          selectedFiles = result.files;
        });
      } else {
        // User canceled the picker
        print('File selection canceled.');
      }
    } catch (e) {
      // Handle any other errors
      print('Error picking files: $e');
    }
  }

  Future<void> _uploadFiles() async {
    setState(() {
      isUploading = true;
    });

    try {
      // Simulate file upload
      await Future.delayed(Duration(seconds: 2));
      widget.onFilesSelected(selectedFiles);

      setState(() {
        selectedFiles = [];
      });

      Navigator.of(context).pop(); // Close the popup after uploading
    } catch (e) {
      print('Error uploading files: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upload PDF Files'),
      content: Container(
        height: 200.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: selectedFiles.isEmpty
                  ? Center(child: Text('No files selected.'))
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: selectedFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedFiles[index].name),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectFiles,
              child: Text('Choose Files'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isUploading ? null : _uploadFiles,
          child: isUploading
              ? CircularProgressIndicator()
              : Text('Upload'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
