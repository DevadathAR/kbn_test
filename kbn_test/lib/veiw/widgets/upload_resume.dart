import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/user_screen/UserHome.dart';

class UploadMyResume extends StatefulWidget {
  const UploadMyResume({super.key});

  @override
  State<UploadMyResume> createState() => _UploadMyResumeState();
}

class _UploadMyResumeState extends State<UploadMyResume> {
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  String? _fileExtension;
  bool _isUploading = false;
  String? _errorMessage;

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
        _errorMessage = null;
      });

      try {
        await _uploadFileToAPI(_selectedFileBytes!, _selectedFileName!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully!')),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to upload file: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload file: $e')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });

        // Navigate to Home after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserHome()),
          );
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

  Future<void> _uploadFileToAPI(Uint8List fileBytes, String fileName) async {
    final uri = Uri.parse('http://192.168.29.37:8000/user/resume/1'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri);

    // Attach file to the request
    request.files.add(http.MultipartFile.fromBytes(
      'resume', // Field name on the server
      fileBytes,
      filename: fileName,
    ));

    // Send the request
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to upload file with status: ${response.statusCode}');
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: 250,
              width: 225,
              child: _isUploading
                  ? Center(child: CircularProgressIndicator())
                  : _selectedFileBytes != null
                      ? (_fileExtension == "jpg" || _fileExtension == "png"
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(_selectedFileBytes!),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.insert_drive_file, size: 50),
                                Text(
                                  _selectedFileName ?? "Selected file",
                                  style: AppTextStyle.abouttxt,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ))
                      : Image.asset(resumePng),
            ),
          ),
        ),
        if (_errorMessage != null)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SnackBar(
              content: Text(_errorMessage!),
              backgroundColor: Colors.red,
            ),
          ),
      ],
    );
  }
}
