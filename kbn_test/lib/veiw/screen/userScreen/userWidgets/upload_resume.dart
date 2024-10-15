import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';

class UploadMyResume extends StatefulWidget {
  final VoidCallback? onResumeUploaded;

  const UploadMyResume({super.key, this.onResumeUploaded});

  @override
  State<UploadMyResume> createState() => _UploadMyResumeState();
}

class _UploadMyResumeState extends State<UploadMyResume> {
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  String? _fileExtension;
  bool _isUploading = false;

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileBytes = result.files.first.bytes;
        _selectedFileName = result.files.first.name;
        _fileExtension = result.files.first.extension;
      });

      // Upload file to the API
      setState(() {
        _isUploading = true;
      });

      try {
        // Simulate API upload
        await ApiServices.uploadResume(_selectedFileBytes!, _selectedFileName!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully!')),
        );

        // Call the callback to notify the parent widget (if provided)
        if (widget.onResumeUploaded != null) {
          widget.onResumeUploaded!();
        }

        // Close the UploadMyResume widget after a successful upload
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const UserHome();
          },
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload file: $e')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    } else {
      setState(() {
        _selectedFileBytes = null;
        _selectedFileName = null;
        _fileExtension = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: semitransp,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: GestureDetector(
            onTap: _isUploading ? null : _selectFile,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 250,
              width: 225,
              child: _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : _selectedFileBytes != null
                      ? (_fileExtension == "jpg" || _fileExtension == "png"
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(_selectedFileBytes!),
                              radius: 50,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.insert_drive_file, size: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedFileName ?? "Selected file",
                                    style: AppTextStyle.thirteenW500,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ))
                      : Image.asset(resumePng),
            ),
          ),
        ),
      ],
    );
  }
}
